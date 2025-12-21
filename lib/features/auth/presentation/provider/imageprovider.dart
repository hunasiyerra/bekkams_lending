import 'dart:io';

import 'package:bekkams_lending/corecomponents/enums/imageenums.dart';
import 'package:bekkams_lending/features/auth/data/domain/models/userimagemodel.dart';
import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:image_picker/image_picker.dart';

class CustomImageProvider extends ChangeNotifier {
  final Firebaserepository firebaserepository;
  CustomImageProvider({required this.firebaserepository});
  final ImagePicker _imagePicker = ImagePicker();
  final TextRecognizer textRecognizer = TextRecognizer();
  final FaceDetector faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: false,
      enableLandmarks: false,
      performanceMode: FaceDetectorMode.fast,
    ),
  );
  final panRegex = RegExp(r'\b[A-Z]{5}[0-9]{4}[A-Z]\b');
  final aadhaarRegex = RegExp(r'\b\d{4}\s\d{4}\s\d{4}\b');

  ImageStatus _displayimage = ImageStatus.start;
  ImagefolderType? _imageFolder;
  String? _imageError;
  String? _panUrl;
  String? _aadharUrl;
  String? _profileUrl;
  String? _panNumber;
  String? _aadharNumber;

  ImageStatus get getimageDisplayed => _displayimage;
  ImagefolderType? get getImageFolder => _imageFolder;
  String? get getImageError => _imageError;
  String? get getPanNumber => _panNumber;
  String? get getAadharNumber => _aadharNumber;
  String get getProfileUrl => _profileUrl ?? "";

  imageFromGallery(String uId, ImagefolderType type) async {
    _imageFolder = type;
    notifyListeners();
    final ImageAnalysisResult<TextBlock>? textBlocks =
        await checkimagetext<TextBlock>(
          ImageSource.gallery,
          ImageAnalysisType.text,
        );
    if (textBlocks != null && textBlocks.data.isNotEmpty) {
      String? textNum;
      if (_imageFolder == ImagefolderType.aadhar) {
        textNum = checkAadharNum(textBlocks.data);
      } else if (_imageFolder == ImagefolderType.pan) {
        textNum = checkPanNum(textBlocks.data);
      }
      if (textNum != null && textNum.isNotEmpty) {
        final value = await uploadimagetoserver(
          uId,
          textBlocks.image.filePath!,
        );
        if (value != null && _imageFolder == ImagefolderType.pan) {
          _panUrl = value;
          _panNumber = textNum;
        } else if (value != null && _imageFolder == ImagefolderType.aadhar) {
          _aadharUrl = value;
          _aadharNumber = textNum;
          _imageError = null;
        } else {
          _imageError = "Unable to upload ${folderFromType(_imageFolder!)}";
        }
      } else if (textNum == null && _imageFolder == ImagefolderType.aadhar) {
        _aadharNumber = null;
        _imageError = "Please Select the valid Aadhar image";
      } else if (textNum == null && _imageFolder == ImagefolderType.pan) {
        _panNumber = null;
        _imageError = "Please Select the valid Pan image";
      }
    } else {
      _imageError =
          "Please Select a ${folderFromType(_imageFolder!)} image to upload";
    }
    notifyListeners();
  }

  String? checkAadharNum(List<TextBlock> textBlocks) {
    _aadharNumber = "Loading";
    notifyListeners();
    List<TextBlock>? data;
    for (var text in textBlocks) {
      if (text.text == "GOVERNMENT OF INDIA") {
        data = textBlocks;
        break;
      } else {
        data = null;
      }
    }
    if (data != null && data.isNotEmpty) {
      for (var test in data) {
        if (aadhaarRegex.hasMatch(test.text) && test.text.trim().length == 14) {
          return test.text;
        }
      }
    } else {
      return null;
    }
    return null;
  }

  String? checkPanNum(List<TextBlock> textBlocks) {
    _panNumber = "Loading";
    notifyListeners();
    List<TextBlock>? data;
    for (var text in textBlocks) {
      if (text.text == "INCOME TAX DEPARTMENT") {
        data = textBlocks;
        break;
      } else {
        data = null;
      }
    }
    if (data != null && data.isNotEmpty) {
      for (var test in data) {
        if (panRegex.hasMatch(test.text) && test.text.trim().length == 10) {
          return test.text;
        }
      }
    } else {
      return null;
    }
    return null;
  }

  uploadImageFromCamera(String uId) async {
    _imageFolder = ImagefolderType.profile;
    _imageError = null;
    notifyListeners();
    final ImageAnalysisResult<Face>? faces = await checkimagetext<Face>(
      ImageSource.camera,
      ImageAnalysisType.face,
    );
    if (faces != null && faces.data.isNotEmpty) {
      _displayimage = ImageStatus.loading;
      notifyListeners();
      final result = await uploadimagetoserver(uId, faces.image.filePath!);
      if (result != null && result.isNotEmpty) {
        _profileUrl = result;
        _displayimage = ImageStatus.success;
      } else {
        _displayimage = ImageStatus.start;
      }
    } else {
      if (_imageError == null) {
        _imageError = "Please capture the image of face";
        _displayimage = ImageStatus.start;
      }
    }
    notifyListeners();
  }

  Future<ImageAnalysisResult<T>?> checkimagetext<T>(
    ImageSource source,
    ImageAnalysisType type,
  ) async {
    final image = await checkSelectedImage(source);
    if (image != null) {
      notifyListeners();
      switch (type) {
        case ImageAnalysisType.text:
          RecognizedText recognizedText = await textRecognizer.processImage(
            image,
          );
          await textRecognizer.close();
          return ImageAnalysisResult<T>(
            data: recognizedText.blocks as List<T>,
            image: image,
          );
        case ImageAnalysisType.face:
          final List<Face> faces = await faceDetector.processImage(image);
          return ImageAnalysisResult<T>(data: faces as List<T>, image: image);
      }
    } else {
      if (_imageError == null) {
        _imageError = "Please upload the image again";
        return null;
      } else {
        return null;
      }
    }
  }

  Future<InputImage?> checkSelectedImage(ImageSource source) async {
    final XFile? file = await _imagePicker.pickImage(source: source);
    if (file != null) {
      int size = await file.length();
      if (size < 5000000) {
        InputImage image = InputImage.fromFilePath(file.path);
        return image;
      } else {
        _imageError = "Please upload the files lessthan 5 MB ";
        return null;
      }
    } else {
      if (_imageError == null) {
        _imageError = "Please upload the file";
        return null;
      } else {
        return null;
      }
    }
  }

  String? errorFor(ImagefolderType type) {
    if (_imageFolder == type) {
      return _imageError;
    }
    return null;
  }

  Future<String?> uploadimagetoserver(String uid, String imagePath) async {
    final folder = folderFromType(_imageFolder!);
    final File file = File(imagePath);
    var data = await firebaserepository.uploadImage(uid, folder, file);
    final result = data.fold((url) => url, (failure) {
      _imageError = "Unable to upload the $folder";
      return null;
    });
    return result;
  }

  Future<String?> saveImageData(String uId) async {
    print(
      "Profile url: $_profileUrl, AadharUrl: $_aadharUrl, panurl: $_panUrl",
    );
    if (_profileUrl != null &&
        _profileUrl!.isNotEmpty &&
        _aadharUrl != null &&
        _aadharUrl!.isNotEmpty &&
        _panUrl != null &&
        _panUrl!.isNotEmpty &&
        _panNumber != null &&
        _panNumber!.isNotEmpty &&
        _aadharNumber != null &&
        _aadharNumber!.isNotEmpty &&
        _imageError == null) {
      final data = await firebaserepository.uploadImagedata(uId, [
        Userimagemodel(
          pan: _panNumber!,
          aadhar: _aadharNumber!,
          profileUrl: _profileUrl!,
          panUrl: _panUrl!,
          aadharUrl: _aadharUrl!,
        ),
      ]);
      final result = data.fold((value) {
        clearState();
        return value;
      }, (failure) => null);
      return result;
    } else {
      _imageFolder = ImagefolderType.none;
      _imageError = "Please upload the images to procced";
      notifyListeners();
      return null;
    }
  }

  String folderFromType(ImagefolderType type) {
    switch (type) {
      case ImagefolderType.pan:
        return "Pan";
      case ImagefolderType.aadhar:
        return "Aadhar";
      case ImagefolderType.profile:
        return "Profile";
      case ImagefolderType.none:
        return "NotUpload";
    }
  }

  void clearState() {
    _imageError = null;
    _imageFolder = null;
    _displayimage = ImageStatus.start;
    notifyListeners();
  }

  @override
  void dispose() {
    faceDetector.close();
    textRecognizer.close();
    super.dispose();
  }
}

class ImageAnalysisResult<T> {
  final InputImage image;
  final List<T> data;

  ImageAnalysisResult({required this.image, required this.data});
}

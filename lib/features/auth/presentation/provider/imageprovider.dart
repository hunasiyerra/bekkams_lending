import 'dart:io';

import 'package:bekkams_lending/features/auth/data/domain/models/userimagemodel.dart';
import 'package:bekkams_lending/features/auth/data/firebaserepository.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'package:image_picker/image_picker.dart';

class CustomImageProvider extends ChangeNotifier {
  final Firebaserepository firebaserepository;
  CustomImageProvider({required this.firebaserepository}) {
    print("This is image provide");
  }

  final ImagePicker _imagePicker = ImagePicker();
  final TextRecognizer textRecognizer = TextRecognizer();
  final panRegex = RegExp(r'\b[A-Z]{5}[0-9]{4}[A-Z]\b');
  final aadhaarRegex = RegExp(r'\b\d{4}\s\d{4}\s\d{4}\b');
  XFile? _file;

  String _displayimage = "StartState";
  String _imageFolder = "Profile";
  String? _profileError;
  String? _aadharError;
  String? _panError;
  String? _sizeError;
  String? _panUrl;
  String? _aadharUrl;
  String? _profileUrl;
  String? _panNumber;
  String? _aadharNumber;

  //XFile? get getimagepath => _file;
  String get getimageDisplayed => _displayimage;
  String? get getAadharError => _aadharError;
  String? get getPanError => _panError;
  String? get getProfileError => _profileError;
  String? get getSizeErroe => _sizeError;
  String? get getPanNumber => _panNumber;
  String? get getAasharNumber => _aadharNumber;
  String get getProfileUrl => _profileUrl ?? "";

  imageFromGallery(String uId) async {
    _file = await _imagePicker.pickImage(source: ImageSource.gallery);
    int size = await _file!.length();
    if (size > 5000000) {
      _sizeError = "Please upload the files lessthan 5 MB ";
    } else {
      InputImage readfile = InputImage.fromFilePath(_file!.path);
      RecognizedText recognizedText = await textRecognizer.processImage(
        readfile,
      );
      //print(recognizedText.text);
      if (recognizedText.blocks.isNotEmpty) {
        List<TextBlock>? data;
        //  print("lengthe of Recognized test: ${recognizedText.blocks.length}");
        for (var text in recognizedText.blocks) {
          if (text.text == "INCOME TAX DEPARTMENT" ||
              text.text == "GOVERNMENT OF INDIA") {
            //print(text.text);
            data = recognizedText.blocks;
            break;
          } else {
            data = null;
          }
        }
        if (data != null && data.isNotEmpty) {
          for (var test in data) {
            if (panRegex.hasMatch(test.text)) {
              _imageFolder = "Pan";
              _panNumber = test.text;
              break;
            } else if (aadhaarRegex.hasMatch(test.text)) {
              _imageFolder = "Aadhar";
              _aadharNumber = test.text;
              break;
            }
          }
          final value = await uploadimagetoserver(uId, File(_file!.path));
          if (value != null && _imageFolder == "Pan") {
            _panUrl = value;
          } else {
            _panError = "Unable to upload Pan";
          }
          if (value != null && _imageFolder == "Aadhar") {
            _aadharUrl = value;
          } else {
            _aadharError = "Unable to upload Aadhar";
          }
        }
      }
    }
    notifyListeners();
  }

  uploadImageFromCamera(String uId) async {
    _displayimage = "Loading";
    notifyListeners();
    _file = await _imagePicker.pickImage(source: ImageSource.camera);
    InputImage image = InputImage.fromFilePath(_file!.path);
    final FaceDetector faceDetector = FaceDetector(
      options: FaceDetectorOptions(
        enableContours: false,
        enableLandmarks: false,
        performanceMode: FaceDetectorMode.fast,
      ),
    );
    final List<Face> faces = await faceDetector.processImage(image);
    await faceDetector.close();
    if (faces.isNotEmpty) {
      final result = await uploadimagetoserver(uId, File(_file!.path));
      if (result != null && result.isNotEmpty) {
        _profileUrl = result;
        _displayimage = "Success";
      } else {
        _profileError = "Unable to upload the data";
      }
    } else {
      _profileError = "Please Capture the image of face";
    }
    notifyListeners();
  }

  Future<String?> uploadimagetoserver(String uid, File file) async {
    var data = await firebaserepository.uploadImage(uid, _imageFolder, file);
    final result = data.fold((url) => url, (failure) => null);
    return result;
  }

  Future<String?> saveImageData(String uId) async {
    if (_profileUrl != null &&
        _profileUrl!.isNotEmpty &&
        _aadharUrl != null &&
        _aadharUrl!.isNotEmpty &&
        _panUrl != null &&
        _panUrl!.isNotEmpty &&
        _panNumber != null &&
        _panNumber!.isNotEmpty &&
        _aadharNumber != null &&
        _aadharNumber!.isNotEmpty) {
      final data = await firebaserepository.uploadImagedata(uId, [
        Userimagemodel(
          pan: _panNumber!,
          aadhar: _aadharNumber!,
          profileUrl: _profileUrl!,
          panUrl: _panUrl!,
          aadharUrl: _aadharUrl!,
        ),
      ]);

      final result = data.fold((value) => value, (failure) => null);
      return result;
    }
    return null;
  }
}

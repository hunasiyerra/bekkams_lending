// ignore_for_file: use_build_context_synchronously

import 'package:bekkams_lending/corecomponents/enums/imageenums.dart';
import 'package:bekkams_lending/features/auth/presentation/home/pages/homepages.dart';
import 'package:bekkams_lending/features/auth/presentation/home/provider/homeprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/provider/imageprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/widget/errortext.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/widget/filledbutton.dart';
import 'package:bekkams_lending/features/auth/presentation/auth/widget/uploadbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageUploadScreen extends StatefulWidget {
  final String uId;
  const ImageUploadScreen({super.key, required this.uId});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CustomImageProvider>(
      builder: (context, imageprovide, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 95,
                          backgroundImage:
                              imageprovide.getProfileUrl.isNotEmpty &&
                                      imageprovide.getimageDisplayed ==
                                          ImageStatus.success
                                  ? NetworkImage(imageprovide.getProfileUrl)
                                  : AssetImage(
                                    'assets/images/placeholderimage.png',
                                  ),
                          child:
                              imageprovide.getProfileUrl.isEmpty &&
                                      imageprovide.getimageDisplayed ==
                                          ImageStatus.loading
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                        Positioned(
                          bottom: 25,
                          right: 15,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey,
                            radius: 15,
                            child: IconButton(
                              onPressed: () {
                                imageprovide.uploadImageFromCamera(widget.uId);
                              },
                              icon: Icon(
                                Icons.camera_alt,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ErrorText(
                      color: Colors.red,
                      error: imageprovide.errorFor(ImagefolderType.profile),
                    ),
                    SizedBox(height: 30),
                    FileUploadButton(
                      buttonName: "Aadhar :",
                      onPressed: () async {
                        await imageprovide.imageFromGallery(
                          widget.uId,
                          ImagefolderType.aadhar,
                        );
                      },
                    ),
                    ErrorText(
                      color:
                          imageprovide.getAadharNumber != null
                              ? Colors.green
                              : Colors.red,
                      fontSize:
                          imageprovide.getAadharNumber != null ? 18 : null,
                      fontWeight:
                          imageprovide.getAadharNumber != null
                              ? FontWeight.bold
                              : null,
                      error:
                          imageprovide.getAadharNumber ??
                          imageprovide.errorFor(ImagefolderType.aadhar),
                    ),
                    SizedBox(height: 30),
                    FileUploadButton(
                      buttonName: "Pan :",
                      onPressed: () async {
                        await imageprovide.imageFromGallery(
                          widget.uId,
                          ImagefolderType.pan,
                        );
                      },
                    ),
                    ErrorText(
                      color:
                          imageprovide.getPanNumber != null
                              ? Colors.green
                              : Colors.red,
                      fontSize: imageprovide.getPanNumber != null ? 18 : null,
                      fontWeight:
                          imageprovide.getPanNumber != null
                              ? FontWeight.bold
                              : null,
                      error:
                          imageprovide.getPanNumber ??
                          imageprovide.errorFor(ImagefolderType.pan),
                    ),
                    SizedBox(height: 50),
                    ErrorText(
                      color: Colors.red,
                      error: imageprovide.errorFor(ImagefolderType.none),
                    ),
                    SizedBox(height: 70),
                    CustomFilledButton(
                      onPressed: () async {
                        final result = await imageprovide.saveImageData(
                          widget.uId,
                        );
                        if (result != null && result.isNotEmpty) {
                          context.read<HomeProfileprovider>().fetchProfileData(
                            widget.uId,
                          );
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (_, __, ___) => MyHomePage(),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        }
                        if (imageprovide.getImageFolder ==
                            ImagefolderType.none) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Unable to Save please try after sometime",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.grey[800],
                            ),
                          );
                        }
                      },
                      buttonName: "Save",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

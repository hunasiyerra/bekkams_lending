import 'package:bekkams_lending/features/auth/presentation/provider/authprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/provider/imageprovider.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/errortext.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/filledbutton.dart';
//import 'package:bekkams_lending/features/auth/presentation/widgets/textfield.dart';
import 'package:bekkams_lending/features/auth/presentation/widgets/uploadbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  // late Imageprovider imageprovider;

  @override
  void initState() {
    super.initState();
    // imageprovider = Imageprovider();
  }

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
                                          "Success"
                                  ? NetworkImage(imageprovide.getProfileUrl)
                                  : AssetImage(
                                    'assets/images/placeholderimage.png',
                                  ),
                          child:
                              imageprovide.getProfileUrl.isEmpty &&
                                      imageprovide.getimageDisplayed ==
                                          "Loading"
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
                                String user =
                                    context
                                        .read<Authenticationprovider>()
                                        .userData!
                                        .uid;
                                imageprovide.uploadImageFromCamera(user);
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
                    ErrorText(error: imageprovide.getProfileError),
                    SizedBox(height: 30),
                    FileUploadButton(
                      buttonName: "Aadhar :",
                      onPressed: () async {
                        //  print("Button Pressed aadhar");
                        //  await imageprovider.imageFromGallery();
                        //  print("image printed");
                        String user =
                            context
                                .read<Authenticationprovider>()
                                .userData!
                                .uid;
                        await imageprovide.imageFromGallery(user);
                      },
                    ),
                    ErrorText(error: imageprovide.getAadharError),
                    SizedBox(height: 30),
                    FileUploadButton(
                      buttonName: "Pan :",
                      onPressed: () async {
                        String user =
                            context
                                .read<Authenticationprovider>()
                                .userData!
                                .uid;
                        await imageprovide.imageFromGallery(user);
                      },
                    ),
                    ErrorText(error: imageprovide.getPanError),
                    SizedBox(height: 150),
                    CustomFilledButton(
                      onPressed: () async {
                        String user =
                            context
                                .read<Authenticationprovider>()
                                .userData!
                                .uid;
                        await imageprovide.saveImageData(user);
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

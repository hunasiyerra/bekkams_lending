// ignore_for_file: use_build_context_synchronously

import 'package:bekkams_lending/corecomponents/enums/imageenums.dart';
import 'package:bekkams_lending/features/presentation/auth/widget/documenttile.dart';
import 'package:bekkams_lending/features/presentation/auth/widget/errortext.dart';
import 'package:bekkams_lending/features/presentation/auth/widget/glasscard.dart';
import 'package:bekkams_lending/features/presentation/home/pages/homepages.dart';
import 'package:bekkams_lending/features/presentation/home/provider/homeprovider.dart';
import 'package:bekkams_lending/features/presentation/auth/provider/imageprovider.dart';
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
      builder: (context, imageProvider, _) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F2027),
                  Color(0xFF203A43),
                  Color(0xFF2C5364),
                ],
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// HEADER
                    const Text(
                      "Verify Identity",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Upload your documents to complete verification",
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),

                    /// PROGRESS
                    LinearProgressIndicator(
                      value: imageProvider.getLinearNum,
                      backgroundColor: Colors.white24,
                      color: Colors.greenAccent,
                    ),
                    const SizedBox(height: 30),

                    /// PROFILE PHOTO CARD
                    MyGlassCard(
                      child: Column(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Profile Photo",
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.black26,
                                backgroundImage:
                                    imageProvider.getProfileUrl.isNotEmpty &&
                                            imageProvider.getimageDisplayed ==
                                                ImageStatus.success
                                        ? NetworkImage(
                                          imageProvider.getProfileUrl,
                                        )
                                        : const AssetImage(
                                              'assets/images/placeholderimage.png',
                                            )
                                            as ImageProvider,
                                child:
                                    imageProvider.getProfileUrl.isEmpty &&
                                            imageProvider.getimageDisplayed ==
                                                ImageStatus.loading
                                        ? CircularProgressIndicator(
                                          color: Colors.white,
                                        )
                                        : null,
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    imageProvider.uploadImageFromCamera(
                                      widget.uId,
                                    );
                                  },
                                  child: const CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.greenAccent,
                                    child: Icon(
                                      Icons.camera_alt,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ErrorText(
                            color: Colors.red,
                            error: imageProvider.errorFor(
                              ImagefolderType.profile,
                            ),
                          ),
                          // const Text(
                          //   "Take a clear photo of your face",
                          //   style: TextStyle(color: Colors.white60),
                          // ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// AADHAR CARD
                    MyDocumentTile(
                      title: "Aadhaar Card",
                      subtitle: "Government issued ID",
                      value:
                          imageProvider.getAadharNumber ??
                          imageProvider.errorFor(ImagefolderType.aadhar),
                      onTap: () async {
                        await imageProvider.imageFromGallery(
                          widget.uId,
                          ImagefolderType.aadhar,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    /// PAN CARD
                    MyDocumentTile(
                      title: "PAN Card",
                      subtitle: "Permanent Account Number",
                      value:
                          imageProvider.getPanNumber ??
                          imageProvider.errorFor(ImagefolderType.pan),
                      onTap: () async {
                        await imageProvider.imageFromGallery(
                          widget.uId,
                          ImagefolderType.pan,
                        );
                      },
                    ),

                    const Spacer(),

                    /// INFO
                    Row(
                      children: const [
                        Icon(Icons.lock, color: Colors.white54, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Your data is secure. Documents are encrypted and never shared.",
                            style: TextStyle(color: Colors.white54),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    /// CONTINUE BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          final result = await imageProvider.saveImageData(
                            widget.uId,
                          );

                          if (result != null && result.isNotEmpty) {
                            context
                                .read<HomeProfileprovider>()
                                .fetchProfileData(widget.uId);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const MyHomePage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Unable to save. Please try again.",
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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

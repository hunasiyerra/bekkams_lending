// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class KYCVerificationScreen extends StatefulWidget {
  const KYCVerificationScreen({super.key});

  @override
  State<KYCVerificationScreen> createState() => _KYCVerificationScreenState();
}

class _KYCVerificationScreenState extends State<KYCVerificationScreen> {
  File? _profileImage;
  bool _aadhaarUploaded = false;
  bool _panUploaded = false;
  final ImagePicker _picker = ImagePicker();

  String aadhaarNumber = '4008 8359 5735';
  String panNumber = 'APAPY4522L';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _profileImage = File(photo.path);
      });
    }
  }

  void _removeProfileImage() {
    setState(() {
      _profileImage = null;
    });
  }

  bool get _isFormComplete {
    return _profileImage != null && _aadhaarUploaded && _panUploaded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0f172a), Color(0xFF1e293b), Color(0xFF0f172a)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Verify Identity',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Step 2 of 3',
                          style: TextStyle(fontSize: 14, color: Colors.white54),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Upload your documents to complete verification',
                      style: TextStyle(fontSize: 14, color: Colors.white54),
                    ),
                    SizedBox(height: 24),
                    // Progress Bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: 0.66,
                        backgroundColor: Colors.white12,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF10b981),
                        ),
                        minHeight: 4,
                      ),
                    ),
                  ],
                ),
              ),

              // Scrollable Content
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    // Profile Photo Card
                    _buildProfilePhotoCard(),
                    SizedBox(height: 20),

                    // Aadhaar Card
                    _buildDocumentCard(
                      title: 'Aadhaar Card',
                      subtitle: 'Government issued ID',
                      isUploaded: _aadhaarUploaded,
                      documentNumber: aadhaarNumber,
                      onUpload: () {
                        setState(() {
                          _aadhaarUploaded = true;
                        });
                      },
                      onClear: () {
                        setState(() {
                          _aadhaarUploaded = false;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // PAN Card
                    _buildDocumentCard(
                      title: 'PAN Card',
                      subtitle: 'Permanent Account Number',
                      isUploaded: _panUploaded,
                      documentNumber: panNumber,
                      onUpload: () {
                        setState(() {
                          _panUploaded = true;
                        });
                      },
                      onClear: () {
                        setState(() {
                          _panUploaded = false;
                        });
                      },
                    ),
                    SizedBox(height: 20),

                    // Security Note
                    _buildSecurityNote(),
                    SizedBox(height: 120),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _buildBottomButton(),
    );
  }

  Widget _buildProfilePhotoCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile Photo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color:
                              _profileImage != null
                                  ? Color(0xFF10b981)
                                  : Colors.white24,
                          width: _profileImage != null ? 4 : 2,
                        ),
                        color: Colors.white.withOpacity(0.05),
                      ),
                      child:
                          _profileImage != null
                              ? ClipOval(
                                child: Image.file(
                                  _profileImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                              : Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.white30,
                              ),
                    ),
                    if (_profileImage != null)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _removeProfileImage,
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          _showImageSourceDialog();
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Color(0xFF10b981),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF10b981).withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'Take a clear photo of your face',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentCard({
    required String title,
    required String subtitle,
    required bool isUploaded,
    required String documentNumber,
    required VoidCallback onUpload,
    required VoidCallback onClear,
  }) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.white38),
                  ),
                ],
              ),
              if (isUploaded)
                Icon(Icons.check_circle, color: Color(0xFF10b981), size: 24),
            ],
          ),
          SizedBox(height: 16),
          if (isUploaded)
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Color(0xFF10b981).withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${title.split(' ')[0]} Number',
                        style: TextStyle(fontSize: 10, color: Colors.white38),
                      ),
                      SizedBox(height: 4),
                      Text(
                        documentNumber,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF10b981),
                          letterSpacing: 1.5,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: onClear,
                    child: Text(
                      'Change',
                      style: TextStyle(fontSize: 12, color: Colors.white54),
                    ),
                  ),
                ],
              ),
            )
          else
            InkWell(
              onTap: onUpload,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.03),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(Icons.upload_file, size: 32, color: Colors.white30),
                    SizedBox(height: 8),
                    Text(
                      'Upload $title',
                      style: TextStyle(fontSize: 14, color: Colors.white54),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'PDF, JPG or PNG (Max 5MB)',
                      style: TextStyle(fontSize: 11, color: Colors.white24),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSecurityNote() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.withOpacity(0.2), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: Colors.blue.shade300, size: 20),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your data is secure',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade300,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'All documents are encrypted and stored securely. We never share your information with third parties.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue.shade200.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.transparent, Color(0xFF0f172a), Color(0xFF0f172a)],
        ),
      ),
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed:
                  _isFormComplete
                      ? () {
                        // Handle continue action
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Verification submitted successfully!',
                            ),
                            backgroundColor: Color(0xFF10b981),
                          ),
                        );
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF10b981),
                disabledBackgroundColor: Colors.white12,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: _isFormComplete ? 8 : 0,
              ),
              child: Text(
                _isFormComplete ? 'Continue' : 'Complete All Steps',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            'By continuing, you agree to our Terms & Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11, color: Colors.white38),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF1e293b),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt, color: Colors.white),
                  title: Text(
                    'Take Photo',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _takePhoto();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library, color: Colors.white),
                  title: Text(
                    'Choose from Gallery',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage();
                  },
                ),
              ],
            ),
          ),
    );
  }
}

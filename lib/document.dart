import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class DocumentVerificationPage extends StatefulWidget {
  static File? selectedLogo;
  static File? certificateOfIncorporation;
  static File? businessPanCard;

  @override
  _DocumentVerificationPageState createState() => _DocumentVerificationPageState();
}

class _DocumentVerificationPageState extends State<DocumentVerificationPage> {
  File? _selectedImage;
  File? _certificateOfIncorporation;
  File? _businessPanCard;
  TextEditingController _aadharController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  Future<void> _getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        DocumentVerificationPage.selectedLogo = _selectedImage;
      });
    }
  }

  Future<void> _getCertificateOfIncorporation() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'txt'],
    );

    if (result != null) {
      setState(() {
        _certificateOfIncorporation = File(result.files.single.path!);
        DocumentVerificationPage.certificateOfIncorporation = _certificateOfIncorporation;
      });
    }
  }

  Future<void> _getBusinessPanCard() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'txt'],
    );

    if (result != null) {
      setState(() {
        _businessPanCard = File(result.files.single.path!);
        DocumentVerificationPage.businessPanCard = _businessPanCard;
      });
    }
  }

  void _submitApplication() {
    // Add logic to submit the application
    // You can use the gathered data like _selectedImage, _aadharController.text, etc.

    // Navigate to the ProfilePage after submitting the application
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFB0C7A6),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.0),

              Text(
                'Document Verification',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20.0),

              Text(
                'Upload Logo',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.0),

              InkWell(
                onTap: _getImage,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: DocumentVerificationPage.selectedLogo != null
                      ? FileImage(DocumentVerificationPage.selectedLogo!)
                      : null,
                  child: DocumentVerificationPage.selectedLogo == null
                      ? Icon(
                    Icons.camera_alt,
                    size: 40.0,
                    color: Colors.grey[600],
                  )
                      : null,
                ),
              ),

              SizedBox(height: 20.0),

              Text(
                'Name of Business',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: _aadharController,
                decoration: InputDecoration(
                  hintText: 'Business name',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20.0),

              Text(
                'Address',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Enter Address',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20.0),

              Text(
                'Website',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: 'Link',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20.0),

              Text(
                'Upload Certificate of Incorporation',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.0),

              InkWell(
                onTap: _getCertificateOfIncorporation,
                child: Container(
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cloud_upload,
                      size: 40.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              Text(
                'Upload Business Pan Card',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 10.0),

              InkWell(
                onTap: _getBusinessPanCard,
                child: Container(
                  height: 100.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[300],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.cloud_upload,
                      size: 40.0,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0),

              SizedBox(height: 30.0), // Additional spacing

              // Submit button
              ElevatedButton(
                onPressed: _submitApplication,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3A4F3B),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Text(
                  'Submit Application',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
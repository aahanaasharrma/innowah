import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class DocumentVerificationPage extends StatefulWidget {
  @override
  _DocumentVerificationPageState createState() => _DocumentVerificationPageState();
}

class _DocumentVerificationPageState extends State<DocumentVerificationPage> {
  File? _selectedImage;
  File? _certificateOfIncorporation;
  File? _businessPanCard;

  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();

  /// **Request Permissions for Android**
  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.photos,
        Permission.manageExternalStorage,
      ].request();

      // If permission is permanently denied, open settings
      if (statuses[Permission.storage]!.isPermanentlyDenied ||
          statuses[Permission.manageExternalStorage]!.isPermanentlyDenied) {
        await openAppSettings();
      }
    }
  }

  /// **Pick an image from the gallery**
  Future<void> _getImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  /// **Pick a document file**
  Future<File?> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null && result.files.single.path != null) {
        return File(result.files.single.path!);
      }
    } catch (e) {
      print("Error picking document: $e");
    }
    return null;
  }

  /// **Select Certificate of Incorporation**
  Future<void> _getCertificateOfIncorporation() async {
    File? file = await _pickDocument();
    if (file != null) {
      setState(() {
        _certificateOfIncorporation = file;
      });
    }
  }

  /// **Select Business PAN Card**
  Future<void> _getBusinessPanCard() async {
    File? file = await _pickDocument();
    if (file != null) {
      setState(() {
        _businessPanCard = file;
      });
    }
  }

  /// **Submit the application**
  void _submitApplication() {
    if (_selectedImage == null || _certificateOfIncorporation == null || _businessPanCard == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please upload all required documents')),
      );
      return;
    }

    print("Business Name: ${_businessNameController.text}");
    print("Address: ${_addressController.text}");
    print("Website: ${_websiteController.text}");
    print("Logo: ${_selectedImage?.path}");
    print("Certificate: ${_certificateOfIncorporation?.path}");
    print("PAN Card: ${_businessPanCard?.path}");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Application submitted successfully!')),
    );
  }

  @override
  void initState() {
    super.initState();
    _requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Document Verification"),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),

            /// **Upload Logo**
            const Text('Upload Logo', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            InkWell(
              onTap: _getImage,
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.grey[300],
                backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                child: _selectedImage == null
                    ? const Icon(Icons.camera_alt, size: 40.0, color: Colors.grey)
                    : null,
              ),
            ),

            const SizedBox(height: 20.0),

            _buildTextField("Name of Business", _businessNameController),
            _buildTextField("Address", _addressController),
            _buildTextField("Website", _websiteController),

            /// **Upload Certificate of Incorporation**
            const SizedBox(height: 20.0),
            const Text('Upload Certificate of Incorporation', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            _buildFileUploadBox(_getCertificateOfIncorporation, _certificateOfIncorporation),

            /// **Upload Business PAN Card**
            const SizedBox(height: 20.0),
            const Text('Upload Business PAN Card', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            _buildFileUploadBox(_getBusinessPanCard, _businessPanCard),

            /// **Submit Button**
            const SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: _submitApplication,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 16.0),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              ),
              child: const Text('Submit Application', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  /// **Reusable File Upload Box**
  Widget _buildFileUploadBox(VoidCallback onTap, File? file) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey[400]!),
        ),
        child: Center(
          child: file == null
              ? const Icon(Icons.cloud_upload, size: 40.0, color: Colors.grey)
              : Text(file.path.split('/').last, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  /// **Reusable TextField Widget**
  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter here',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}

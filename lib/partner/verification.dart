import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:healthconnect/api/parnerapi.dart';
import 'package:healthconnect/partner/sndclude.dart';

class VerificationScreen extends StatefulWidget {
  final bool documentsVerified;
  final bool termsAccepted;

  const VerificationScreen({
    Key? key,
    required this.documentsVerified,
    required this.termsAccepted,
  }) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final PartnerApiService _apiService = PartnerApiService();
  bool _isLoading = false;
  bool _documentsVerified = false;
  bool _termsAccepted = false;
  String? _termsContent;
  File? _identityDocument;
  File? _qualificationDocument;
  File? _licenseDocument;

  @override
  void initState() {
    super.initState();
    _documentsVerified = widget.documentsVerified;
    _termsAccepted = widget.termsAccepted;
    _loadTerms();
  }

  Future<void> _loadTerms() async {
    setState(() {
      _isLoading = true;
    });

    final content = await _apiService.getTermsContent();

    setState(() {
      _termsContent = content ?? 'Unable to load terms and conditions.';
      _isLoading = false;
    });
  }

  Future<void> _pickDocument(String type) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        if (type == 'identity') {
          _identityDocument = File(pickedFile.path);
        } else if (type == 'qualification') {
          _qualificationDocument = File(pickedFile.path);
        } else if (type == 'license') {
          _licenseDocument = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _uploadDocuments() async {
    if (_identityDocument == null ||
        _qualificationDocument == null ||
        _licenseDocument == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please upload all required documents'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    bool success = true;

    // Upload identity document
    success =
        success &&
        await _apiService.uploadDocument(_identityDocument!, 'identity');

    // Upload qualification document
    success =
        success &&
        await _apiService.uploadDocument(
          _qualificationDocument!,
          'qualification',
        );

    // Upload license document
    success =
        success &&
        await _apiService.uploadDocument(_licenseDocument!, 'license');

    setState(() {
      _isLoading = false;
      if (success) {
        _documentsVerified = true;
      }
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Documents uploaded successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      _checkCompletionAndNavigate();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload documents. Please try again.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _acceptTerms() async {
    setState(() {
      _isLoading = true;
    });

    final success = await _apiService.acceptTerms();

    setState(() {
      _isLoading = false;
      if (success) {
        _termsAccepted = true;
      }
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terms accepted successfully!'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );

      _checkCompletionAndNavigate();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to accept terms. Please try again.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _checkCompletionAndNavigate() {
    if (_documentsVerified && _termsAccepted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => PartnerDashboard()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Verification'),
        automaticallyImplyLeading: false,
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complete Your Profile',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Please complete these steps to verify your account',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 32),

                      // Documents section
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _documentsVerified
                                      ? Icons.check_circle
                                      : Icons.file_copy,
                                  color:
                                      _documentsVerified
                                          ? Colors.green
                                          : Color(0xFF009688),
                                  size: 28,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    'Document Verification',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                if (_documentsVerified)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Completed',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            if (!_documentsVerified) ...[
                              SizedBox(height: 16),
                              Text(
                                'Please upload the following documents:',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(height: 16),

                              // ID proof
                              _buildDocumentUploadItem(
                                'Identity Proof',
                                'Upload your ID (Aadhaar/PAN/Voter ID)',
                                _identityDocument != null,
                                () => _pickDocument('identity'),
                              ),
                              SizedBox(height: 16),

                              // Qualification proof
                              _buildDocumentUploadItem(
                                'Qualification Certificate',
                                'Upload your highest qualification',
                                _qualificationDocument != null,
                                () => _pickDocument('qualification'),
                              ),
                              SizedBox(height: 16),

                              // License
                              _buildDocumentUploadItem(
                                'Medical License',
                                'Upload your valid medical license',
                                _licenseDocument != null,
                                () => _pickDocument('license'),
                              ),
                              SizedBox(height: 24),

                              // Upload button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _uploadDocuments,
                                  child: Text('UPLOAD DOCUMENTS'),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      SizedBox(height: 24),

                      // Terms and conditions section
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  _termsAccepted
                                      ? Icons.check_circle
                                      : Icons.description,
                                  color:
                                      _termsAccepted
                                          ? Colors.green
                                          : Color(0xFF009688),
                                  size: 28,
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    'Terms & Conditions',
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                if (_termsAccepted)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      'Accepted',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            if (!_termsAccepted) ...[
                              SizedBox(height: 16),
                              Container(
                                height: 200,
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    _termsContent ?? 'Loading terms...',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),

                              // Accept button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _acceptTerms,
                                  child: Text('ACCEPT TERMS'),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildDocumentUploadItem(
    String title,
    String subtitle,
    bool isUploaded,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isUploaded ? Colors.green : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isUploaded ? Icons.check_circle : Icons.upload_file,
              color: isUploaded ? Colors.green : Colors.grey[600],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    isUploaded ? 'Document uploaded' : subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PartnerApiService {
  // Replace with your actual API base URL
  static const String baseUrl = 'https://your-api-domain.com/api';
  
  // HTTP client for making API requests
  final http.Client _client = http.Client();
  
  // Headers for API requests
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
  
  // Add authentication token to headers if available
  Future<Map<String, String>> get _authHeaders async {
    final headers = Map<String, String>.from(_headers);
    final token = await _getToken();
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
  
  // Store token in shared preferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('partner_auth_token', token);
  }
  
  // Get token from shared preferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('partner_auth_token');
  }
  
  // Clear token from shared preferences (for logout)
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('partner_auth_token');
  }
  
  // Request OTP for login
  Future<bool> requestOtp(String phoneNumber) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/partner/auth/request-otp'),
        headers: _headers,
        body: jsonEncode({
          'phone_number': phoneNumber,
        }),
      );
      
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to send OTP: ${response.body}');
      }
    } catch (e) {
      print('Error requesting OTP: $e');
      return false;
    }
  }
  
  // Verify OTP and login
  Future<Map<String, dynamic>?> verifyOtp(String phoneNumber, String otp) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/partner/auth/verify-otp'),
        headers: _headers,
        body: jsonEncode({
          'phone_number': phoneNumber,
          'otp': otp,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['token'] != null) {
          await _saveToken(data['token']);
        }
        return data;
      } else {
        throw Exception('Failed to verify OTP: ${response.body}');
      }
    } catch (e) {
      print('Error verifying OTP: $e');
      return null;
    }
  }
  
  // Register new partner
  Future<bool> registerPartner(
    String name, 
    String phoneNumber, 
    String email,
    String specialization,
    String experience,
  ) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/partner/auth/register'),
        headers: _headers,
        body: jsonEncode({
          'name': name,
          'phone_number': phoneNumber,
          'email': email,
          'specialization': specialization,
          'experience': experience,
        }),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to register partner: ${response.body}');
      }
    } catch (e) {
      print('Error registering partner: $e');
      return false;
    }
  }
  
  // Upload document
  Future<bool> uploadDocument(File document, String documentType) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/partner/documents/upload'),
      );
      
      final headers = await _authHeaders;
      request.headers.addAll(headers);
      
      request.fields['document_type'] = documentType;
      request.files.add(
        await http.MultipartFile.fromPath(
          'document',
          document.path,
        ),
      );
      
      var response = await request.send();
      
      if (response.statusCode == 200) {
        return true;
      } else {
        final responseBody = await response.stream.bytesToString();
        throw Exception('Failed to upload document: $responseBody');
      }
    } catch (e) {
      print('Error uploading document: $e');
      return false;
    }
  }
  
  // Check verification status
  Future<Map<String, dynamic>?> getVerificationStatus() async {
    try {
      final headers = await _authHeaders;
      final response = await _client.get(
        Uri.parse('$baseUrl/partner/verification/status'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to get verification status: ${response.body}');
      }
    } catch (e) {
      print('Error getting verification status: $e');
      return null;
    }
  }
  
  // Accept terms and conditions
  Future<bool> acceptTerms() async {
    try {
      final headers = await _authHeaders;
      final response = await _client.post(
        Uri.parse('$baseUrl/partner/terms/accept'),
        headers: headers,
      );
      
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to accept terms: ${response.body}');
      }
    } catch (e) {
      print('Error accepting terms: $e');
      return false;
    }
  }
  
  // Get terms and conditions content
  Future<String?> getTermsContent() async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/partner/terms/content'),
        headers: _headers,
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['content'];
      } else {
        throw Exception('Failed to get terms content: ${response.body}');
      }
    } catch (e) {
      print('Error getting terms content: $e');
      return null;
    }
  }
  
  // Check if partner is logged in
  Future<bool> isLoggedIn() async {
    final token = await _getToken();
    return token != null;
  }
}

// Create a new file: lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
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
    await prefs.setString('auth_token', token);
  }
  
  // Get token from shared preferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
  
  // Clear token from shared preferences (for logout)
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }
  
  // Request OTP for login
  Future<bool> requestOtp(String phoneNumber) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/request-otp'),
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
        Uri.parse('$baseUrl/auth/verify-otp'),
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
  
  // Register new user
  Future<bool> registerUser(String name, String phoneNumber, String email) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: _headers,
        body: jsonEncode({
          'name': name,
          'phone_number': phoneNumber,
          'email': email,
        }),
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      print('Error registering user: $e');
      return false;
    }
  }
  
  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    final token = await _getToken();
    return token != null;
  }
}

// // main.dart
// import 'package:flutter/material.dart';
// import 'package:nextapp/api/api.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _phoneNumber = '';
//   bool _isLoading = false;
//   final ApiService _apiService = ApiService();

//   Future<void> _sendOTP() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
      
//       setState(() {
//         _isLoading = true;
//       });
      
//       // Call API to request OTP
//       final success = await _apiService.requestOtp(_phoneNumber);
      
//       setState(() {
//         _isLoading = false;
//       });
      
//       if (success) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => OTPPage(phoneNumber: _phoneNumber),
//           ),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to send OTP. Please try again.'),
//             backgroundColor: Colors.red,
//           ),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[800]!, Colors.blue[400]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Hero(
//                     tag: 'logo',
//                     child: Icon(
//                       Icons.local_hospital,
//                       size: 80,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Healthcare Booking',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   Card(
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               labelText: 'Phone Number',
//                               prefixText: '+91 ',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor: Colors.grey[100],
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty)
//                                 return 'Please enter phone number';
//                               if (value.length != 10)
//                                 return 'Enter valid 10-digit number';
//                               return null;
//                             },
//                             onSaved: (value) => _phoneNumber = value!,
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue[800],
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 50,
//                                 vertical: 15,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _formKey.currentState!.save();
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder:
//                                         (context) =>
//                                             OTPPage(phoneNumber: _phoneNumber),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Text(
//                               'Send OTP',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RegistrationPage(),
//                         ),
//                       );
//                     },
//                     child: Text(
//                       'New User? Register Here',
//                       style: TextStyle(color: Colors.white, fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // registration_page.dart

// class RegistrationPage extends StatefulWidget {
//   @override
//   _RegistrationPageState createState() => _RegistrationPageState();
// }

// class _RegistrationPageState extends State<RegistrationPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _name = '';
//   String _phoneNumber = '';
//   String _email = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[800]!, Colors.blue[400]!],
//           ),
//         ),
//         child: SafeArea(
//           child: SingleChildScrollView(
//             padding: EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 children: [
//                   Hero(
//                     tag: 'logo',
//                     child: Icon(
//                       Icons.local_hospital,
//                       size: 80,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Register',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 40),
//                   Card(
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             decoration: InputDecoration(
//                               labelText: 'Full Name',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor: Colors.grey[100],
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty)
//                                 return 'Please enter your name';
//                               return null;
//                             },
//                             onSaved: (value) => _name = value!,
//                           ),
//                           SizedBox(height: 16),
//                           TextFormField(
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               labelText: 'Phone Number',
//                               prefixText: '+91 ',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor: Colors.grey[100],
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty)
//                                 return 'Please enter phone number';
//                               if (value.length != 10)
//                                 return 'Enter valid 10-digit number';
//                               return null;
//                             },
//                             onSaved: (value) => _phoneNumber = value!,
//                           ),
//                           SizedBox(height: 16),
//                           TextFormField(
//                             keyboardType: TextInputType.emailAddress,
//                             decoration: InputDecoration(
//                               labelText: 'Email (Optional)',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor: Colors.grey[100],
//                             ),
//                             onSaved: (value) => _email = value ?? '',
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue[800],
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 50,
//                                 vertical: 15,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _formKey.currentState!.save();
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder:
//                                         (context) =>
//                                             OTPPage(phoneNumber: _phoneNumber),
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Text(
//                               'Send OTP',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class OTPPage extends StatefulWidget {
//   final String phoneNumber;
//   OTPPage({required this.phoneNumber});

//   @override
//   _OTPPageState createState() => _OTPPageState();
// }

// class _OTPPageState extends State<OTPPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _otp = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[800]!, Colors.blue[400]!],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Icon(Icons.verified_user, size: 80, color: Colors.white),
//                   SizedBox(height: 20),
//                   Text(
//                     'Verify OTP',
//                     style: TextStyle(
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     'Enter OTP sent to +91 ${widget.phoneNumber}',
//                     style: TextStyle(color: Colors.white70, fontSize: 16),
//                   ),
//                   SizedBox(height: 40),
//                   Card(
//                     elevation: 8,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           TextFormField(
//                             keyboardType: TextInputType.number,
//                             maxLength: 6,
//                             decoration: InputDecoration(
//                               labelText: 'OTP',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                               filled: true,
//                               fillColor: Colors.grey[100],
//                             ),
//                             validator: (value) {
//                               if (value == null || value.isEmpty)
//                                 return 'Please enter OTP';
//                               if (value.length != 6)
//                                 return 'OTP should be 6 digits';
//                               return null;
//                             },
//                             onSaved: (value) => _otp = value!,
//                           ),
//                           SizedBox(height: 20),
//                           ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue[800],
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: 50,
//                                 vertical: 15,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 _formKey.currentState!.save();
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                     content: Text('OTP Verified Successfully'),
//                                     backgroundColor: Colors.green,
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Text(
//                               'Verify OTP',
//                               style: TextStyle(fontSize: 18),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

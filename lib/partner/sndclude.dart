// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nextapp/api/parnerapi.dart';
// import 'package:nextapp/partner/loginpage.dart';

// // Success Dialog with animation

// // Partner Registration Page

// // Verification Screen

// // Partner Dashboard
// class PartnerDashboard extends StatefulWidget {
//   @override
//   _PartnerDashboardState createState() => _PartnerDashboardState();
// }

// class _PartnerDashboardState extends State<PartnerDashboard> {
//   int _selectedIndex = 0;
//   final PartnerApiService _apiService = PartnerApiService();

//   // Sample dashboard data (replace with API calls in production)
//   final Map<String, dynamic> _dashboardData = {
//     'appointments': {'today': 5, 'upcoming': 12, 'completed': 143},
//     'earnings': {'today': 2500, 'thisWeek': 12500, 'thisMonth': 45000},
//     'ratings': 4.8,
//     'reviews': 87,
//   };

//   // Sample appointments data
//   final List<Map<String, dynamic>> _appointments = [
//     {
//       'id': 'APT001',
//       'patientName': 'Rahul Sharma',
//       'date': 'Today',
//       'time': '10:30 AM',
//       'type': 'Video Consultation',
//       'status': 'Upcoming',
//       'imageUrl': null,
//     },
//     {
//       'id': 'APT002',
//       'patientName': 'Priya Patel',
//       'date': 'Today',
//       'time': '02:15 PM',
//       'type': 'In-person',
//       'status': 'Upcoming',
//       'imageUrl': null,
//     },
//     {
//       'id': 'APT003',
//       'patientName': 'Amit Kumar',
//       'date': 'Tomorrow',
//       'time': '11:00 AM',
//       'type': 'Video Consultation',
//       'status': 'Upcoming',
//       'imageUrl': null,
//     },
//     {
//       'id': 'APT004',
//       'patientName': 'Sneha Gupta',
//       'date': 'Apr 5, 2025',
//       'time': '09:30 AM',
//       'type': 'In-person',
//       'status': 'Upcoming',
//       'imageUrl': null,
//     },
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Future<void> _signOut() async {
//     await _apiService.clearToken();
//     Navigator.pushAndRemoveUntil(
//       context,
//       MaterialPageRoute(builder: (context) => PartnerLoginPage()),
//       (route) => false,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: [
//           // _buildHomeTab(),
//           // _buildAppointmentsTab(),
//           // _buildProfileTab(),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: Offset(0, -5),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               activeIcon: Icon(Icons.home),
//               label: 'Home',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today_outlined),
//               activeIcon: Icon(Icons.calendar_today),
//               label: 'Appointments',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               activeIcon: Icon(Icons.person),
//               label: 'Profile',
//             ),
//           ],
//           currentIndex: _selectedIndex,
//           selectedItemColor: Color(0xFF009688),
//           unselectedItemColor: Colors.grey[600],
//           showUnselectedLabels: true,
//           onTap: _onItemTapped,
//           elevation: 0,
//           backgroundColor: Colors.white,
//           type: BottomNavigationBarType.fixed,
//           selectedLabelStyle: GoogleFonts.poppins(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//           unselectedLabelStyle: GoogleFonts.poppins(
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget _buildHomeTab() {
//   //   return SafeArea(
//   //     child: CustomScrollView(
//   //       slivers: [
//   //         // App Bar
//   //         SliverAppBar(
//   //           pinned: true,
//   //           backgroundColor: Colors.white,
//   //           elevation: 0,
//   //           title: Text(
//   //             'Dashboard',
//   //             style: GoogleFonts.poppins(
//   //               fontWeight: FontWeight.bold,
//   //             ),
//   //           ),
//   //           actions: [
//   //             IconButton(
//   //               icon: Icon(Icons.notifications_outlined),
//   //               onPressed: () {
//   //                 // Show notifications
//   //               },
//   //             ),
//   //           ],
//   //         ),

//   //         // Dashboard content
//   //         SliverPadding(
//   //           padding: EdgeInsets.all(16),
//   //           sliver: SliverList(
//   //             delegate: SliverChildListDelegate([
//   //               // Welcome card
//   //               Container(
//   //                 padding: EdgeInsets.all(20),
//   //                 decoration: BoxDecoration(
//   //                   gradient: LinearGradient(
//   //                     begin: Alignment.topLeft,
//   //                     end: Alignment.bottomRight,
//   //                     colors: [Color(0xFF009688), Color(0xFF4DB6AC)],
//   //                   ),
//   //                   borderRadius: BorderRadius.circular(16),
//   //                 ),
//   //                 child: Column(
//   //                   crossAxisAlignment: CrossAxisAlignment.start,
//   //                   children: [
//   //                     Row(
//   //                       children: [
//   //                         CircleAvatar(
//   //                           backgroundColor: Colors.white,
//   //                           radius: 24,
//   //                           child: Icon(
//   //                             Icons.person,
//   //                             color: Color(0xFF009688),
//   //                             size: 28,
// }

import 'package:flutter/material.dart';

class PartnerDashboard extends StatefulWidget {
  const PartnerDashboard({super.key});

  @override
  State<PartnerDashboard> createState() => PartnerDashboardState();
}

class PartnerDashboardState extends State<PartnerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("PARTNERS PAGE")));
  }
}

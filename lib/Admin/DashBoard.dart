// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smit_job_portal/Admin/AdminDrawer.dart';
import 'package:smit_job_portal/Admin/DoctorsRegisteration.dart';
import 'package:smit_job_portal/Admin/ManageUsers.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String adminName = "Admin Name"; // Replace with dynamic admin name

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          elevation: 0,
          title: Text(
            "Admin Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),

        drawer: Drawer(
          child: AdminDrawerData(),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              _buildWelcomeSection(),
              SizedBox(height: 20),

              // Quick Actions Section
              _buildQuickActions(),

              // Recent Activity Section
              _buildRecentActivity(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigoAccent, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome Back,",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 5),
          Text(
            adminName,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Manage the application with ease.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            physics: NeverScrollableScrollPhysics(),
            children: [
              AdminActionCard(
                icon: Icons.local_hospital,
                title: "Manage Doctors",
                color: Colors.teal,
                onTap: () {
                  print("Manage Doctors clicked");
                  Get.to(() => RegisterDoctorPage());
                },
              ),
              AdminActionCard(
                icon: Icons.person,
                title: "Manage Users",
                color: Colors.orange,
                onTap: () {
                  print("Manage Users clicked");
                  Get.to(ManageUsersPage());
                },
              ),
              AdminActionCard(
                icon: Icons.bar_chart,
                title: "View Reports",
                color: Colors.purple,
                onTap: () {
                  print("View Reports clicked");
                  // Add dynamic navigation or functionality here
                },
              ),
              AdminActionCard(
                icon: Icons.settings,
                title: "Settings",
                color: Colors.blue,
                onTap: () {
                  print("Settings clicked");
                  // Add dynamic navigation or functionality here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ActivityTile(
            icon: Icons.local_hospital,
            color: Colors.teal,
            title: "Dr. John Doe added to Cardiologists",
            subtitle: "2 hours ago",
          ),
          ActivityTile(
            icon: Icons.person,
            color: Colors.orange,
            title: "New User Registered: Jane Smith",
            subtitle: "4 hours ago",
          ),
        ],
      ),
    );
  }
}

// Admin Action Card Widget
class AdminActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const AdminActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: color,
            ),
            SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Recent Activity Tile Widget
class ActivityTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const ActivityTile({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(
          icon,
          color: color,
        ),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}

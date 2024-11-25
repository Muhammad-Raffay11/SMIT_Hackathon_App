// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smit_job_portal/Admin/DashBoard.dart';
import 'package:smit_job_portal/Admin/DoctorsRegisteration.dart';
import 'package:smit_job_portal/Admin/ManageUsers.dart';
import 'package:smit_job_portal/Auth/Login.dart';

class AdminDrawerData extends StatefulWidget {
  const AdminDrawerData({super.key});

  @override
  State<AdminDrawerData> createState() => _AdminDrawerDataState();
}

class _AdminDrawerDataState extends State<AdminDrawerData> {
  var name = "";
  var email = "";

  @override
  void initState() {
    super.initState();
    setData();
  }

  setData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString("name") ?? "Admin Name";
    email = prefs.getString("email") ?? "admin@example.com";

    setState(() {});
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Get.offAll(LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // Modern Header
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigoAccent, Colors.blueAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.supervised_user_circle_rounded,
                  color: Colors.indigoAccent,
                  size: 45,
                ),
              ),
              SizedBox(height: 8),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                email,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),

        // Navigation Items
        Column(
          children: [
            buildMenuItem(
              icon: Icons.home,
              title: "Home",
              onTap: () => Get.to(AdminDashboard()),
            ),
            buildMenuItem(
              icon: Icons.person_add_alt,
              title: "Add Doctors",
              onTap: () => Get.to(RegisterDoctorPage()),
            ),
            buildMenuItem(
              icon: Icons.category,
              title: "Users",
              onTap: () {
                Get.to(ManageUsersPage());
              },
            ),
         
           
            buildMenuItem(
              icon: Icons.settings,
              title: "Settings",
              onTap: () {
                // Navigate to Settings
              },
            ),
            buildMenuItem(
              icon: Icons.logout,
              title: "Log Out",
              onTap: logout,
            ),
          ],
        ),
      ],
    );
  }

  // Helper method for menu items
  Widget buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.indigoAccent, size: 30),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      onTap: onTap,
    );
  }
}

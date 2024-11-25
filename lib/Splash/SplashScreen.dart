// ignore_for_file: annotate_overrides, prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smit_job_portal/Admin/DashBoard.dart';
import 'package:smit_job_portal/Auth/Login.dart';
import 'package:smit_job_portal/Users/UsersDashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

   void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), (() {
        chesckUser();
    }));
  }

  chesckUser() async {
final SharedPreferences prefs = await SharedPreferences.getInstance();
var userCheck = prefs.getBool('Login')??false;
if(userCheck){

  var userType = prefs.getString('userType');
  if(userType=='Admin'){
      Get.offAll(AdminDashboard());
  }
  else{
    Get.offAll(UserDashboard());
  }

}

else{
  Get.offAll(LoginPage());
}

}


  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Center(
          child: Image.network(
              "https://img.freepik.com/free-vector/bird-colorful-logo-gradient-vector_343694-1365.jpg?t=st=1722092962~exp=1722096562~hmac=6dba715e83ca9513cc06ac9b36c21744be36b4697513fc9a230038c0a5cda43c&w=360"),
        ),
      ),
    );
  }
}
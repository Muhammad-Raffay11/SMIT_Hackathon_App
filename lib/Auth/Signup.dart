// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_null_comparison, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smit_job_portal/Controller/AuthController.dart';

final _formKey = GlobalKey<FormState>();

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  void signUp() {
    final authController = Get.find<AuthController>();
    if (emailController.text.isEmpty) {
      showErrorMessage("Error", "Please enter email");
    } else if (passwordController.text.isEmpty) {
      showErrorMessage("Error", "Please enter Password");
    } else if (nameController.text.isEmpty) {
      showErrorMessage("Error", "Please enter username");
    } else {
      authController.signUpUser(
        emailController.text,
        passwordController.text,
        nameController.text,
      );
    }
  }

  void showErrorMessage(String err, String message) {
    Get.snackbar(
      err,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      borderRadius: 20,
      borderColor: Colors.green,
      borderWidth: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        // Check if controller is initialized and non-null
        if (controller == null) {
          return Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [
                   Colors.blue.shade900,
                Colors.blue.shade600,
                Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SignUp',
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                        Text(
                          'Be a member now',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 20,
                                      offset: Offset(0, 18),
                                    ),
                                  ],
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      buildTextField(nameController, 'Username'),
                                      buildTextField(emailController, 'Email'),
                                      buildTextField(passwordController, 'Password'),
                                      buildTextField(null, 'Phone'),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 24),
                              controller.isLoading == true
                                  ? CircularProgressIndicator()
                                  : GestureDetector(
                                      onTap: signUp,
                                      child: Container(
                                        height: 50,
                                        margin: EdgeInsets.symmetric(horizontal: 50),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.orange.shade900,
                                        ),
                                        child: Center(
                                          child: Text(
                                            'SignUp',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(height: 18),
                              Text(
                                'Continue with social media',
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 18),
                              Row(
                                children: [
                                  buildSocialButton('Facebook', Colors.blue),
                                  SizedBox(width: 30),
                                  buildSocialButton('Google', Colors.black),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(TextEditingController? controller, String hintText) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildSocialButton(String text, Color color) {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
// ignore_for_file: avoid_print, non_constant_identifier_names, avoid_types_as_parameter_names, prefer_const_constructors, file_names, no_leading_underscores_for_local_identifiers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smit_job_portal/Admin/DashBoard.dart';
import 'package:smit_job_portal/Auth/Login.dart';
import 'package:smit_job_portal/Users/UsersDashboard.dart';

class AuthController extends GetxController {
  bool isLoading = false;
  bool password = false;

  setLoading(bool val) {
    isLoading = val;
    update();
  }

  setPassword(bool val) {
    password = !val;
    update();
  }

  void ErrorMessage(String err, String message) {
    Get.snackbar(err, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        borderRadius: 20,
        borderColor: err == "error" ? Colors.red : Colors.green,
        borderWidth: 3);
  }

  // Sign-up user as a normal user
  Future<void> signUpUser(String email, String password, String name) async {
    try {
      setLoading(true);
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var obj = {
        "name": name,
        "email": email,
        "password": password,
        "type": "users",
        "block": false,
      };

      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      await users.doc(userCredential.user!.uid).set(obj);

      setLoading(false);
      ErrorMessage("Success", "User Registered Successfully");
      Get.to(LoginPage());
    } catch (e) {
      setLoading(false);
      ErrorMessage("error", e.toString());
    }
  }

 Future<void> signUpUserAsDoctor(
    String email, String password, String name, String description) async {
  try {
    setLoading(true);

    // Create user in Firebase Authentication
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    // Prepare the data to save in Firestore
    var doctorData = {
      "name": name,
      "email": email,
      "password": password, // Include password explicitly
      "description": description, // Add description field
      "type": "Doctors",
      "block": false,
    };

    // Log for debugging purposes
    print("Saving to Firestore: $doctorData");

    // Reference to Firestore collection
    CollectionReference doctors =
        FirebaseFirestore.instance.collection('Doctors');

    // Save the data under the user's UID
    await doctors.doc(userCredential.user!.uid).set(doctorData);

    setLoading(false);
    ErrorMessage("Success", "Doctor Registered Successfully");
    Get.to(LoginPage());
  } catch (e) {
    setLoading(false);
    ErrorMessage("error", e.toString());
    print("Error during sign-up: $e");
  }
}



  Future<void> setPreference(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("Login", true);
    prefs.setString("userType", data["type"]);
    prefs.setString("email", data["email"]);
    prefs.setString("name", data["name"]);
  }

  // Login user based on their type
  Future<void> LoginUser(String email, String password) async {
    try {
      setLoading(true);
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userId = userCredential.user!.uid;

      // Check in Users collection
      FirebaseFirestore.instance.collection('users').doc(userId).get().then(
          (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          var data = documentSnapshot.data() as Map<String, dynamic>;
          if (data["block"] == true) {
            ErrorMessage("Block", "Contact Admin");
          } else {
            setPreference(data);
            Get.offAll(UserDashboard());
          }
        } else {
          // Check in Admin collection
          FirebaseFirestore.instance.collection('Admin').doc(userId).get().then(
              (DocumentSnapshot adminDoc) {
            if (adminDoc.exists) {
              var data = adminDoc.data() as Map<String, dynamic>;
              setPreference(data);
              Get.to(AdminDashboard());
            } else {
              // Check in Doctors collection
              FirebaseFirestore.instance
                  .collection('Doctors')
                  .doc(userId)
                  .get()
                  .then((DocumentSnapshot doctorDoc) {
                if (doctorDoc.exists) {
                  var data = doctorDoc.data() as Map<String, dynamic>;
                  setPreference(data);
                  Get.offAll(() => AdminDashboard()); // Replace with DoctorDashboard if available
                } else {
                  ErrorMessage("error", "Document does not exist");
                }
              });
            }
          });
        }
      });
    } catch (e) {
      setLoading(false);
      ErrorMessage("error", e.toString());
    }
  }
}
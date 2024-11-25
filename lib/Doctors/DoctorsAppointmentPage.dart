// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';

class DoctorAppointmentPage extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final String imageUrl;

  const DoctorAppointmentPage({
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Doctor Details',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Picture
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(110),
                      border: Border.all(color: Colors.black,width: 3)
                    ),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: NetworkImage(imageUrl),
                      onBackgroundImageError: (_, __) {
                        // Fallback to an icon if the image fails
                        Icon(Icons.person, size: 70, color: Colors.grey);
                      },
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  SizedBox(height: 20),
                    
                  // Doctor's Name
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                    
                  // Category
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                    
                  // Description Box
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About the Doctor',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                    
                  // Book Appointment Button
                  ElevatedButton(
                    onPressed: () {
                      // Simulate loading and show a Snackbar
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          Future.delayed(Duration(seconds: 2), () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Appointment Sent!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          });
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigoAccent,
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.calendar_today,color: Colors.black,),
                        SizedBox(width: 10),
                        Text('Book Appointment',
                        style: TextStyle(
                          color: Colors.black
                        ),),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

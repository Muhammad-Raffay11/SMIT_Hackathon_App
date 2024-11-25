// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, unnecessary_to_list_in_spreads

import 'package:flutter/material.dart';
import 'package:smit_job_portal/Doctors/DoctorsAppointmentPage.dart';
import 'package:smit_job_portal/Users/UserDrawer.dart';

class UserDashboard extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. John Doe',
      'category': 'Cardiologist',
      'description': 'Expert in Heart-related issues.',
      'imageUrl':
          'https://img.freepik.com/free-photo/doctor-with-his-arms-crossed-white-background_1368-5790.jpg?ga=GA1.1.26211853.1698242772&semt=ais_hybrid', // Replace with actual doctor image URL
    },
    {
      'name': 'Dr. Jane Smith',
      'category': 'Dermatologist',
      'description': 'Expert in Skin-related issues.',
      'imageUrl':
          'https://img.freepik.com/premium-photo/happy-young-male-doctor-man-smile-handsome_79295-13356.jpg?ga=GA1.1.26211853.1698242772&semt=ais_hybrid', // Replace with actual doctor image URL
    },
    {
      'name': 'Dr. Sohail Usman',
      'category': 'Nephrologist',
      'description': 'Expert in Kidney-related issues.',
      'imageUrl':
          'https://doximity-res.cloudinary.com/images/c_crop,f_auto,h_320,q_auto,t_profile_photo_320x320,w_320,x_0,y_0/wysldr5ic0by1gxjovft/sohail-usman-md-indianapolis-in.jpg', // Replace with actual doctor image URL
    },
    {
      'name': 'Dr. Sarah',
      'category': 'ENT',
      'description': 'Expert in ENT-related issues.',
      'imageUrl':
          'https://img.freepik.com/free-photo/front-view-female-doctor_23-2148847616.jpg?ga=GA1.1.26211853.1698242772&semt=ais_hybrid', // Replace with actual doctor image URL
    },
    {
      'name': 'Dr. Ahmed',
      'category': 'Arthopedic',
      'description': 'Expert in Artho-related issues.',
      'imageUrl':
          'https://img.freepik.com/free-photo/medium-shot-doctor-with-stethoscope_23-2148816188.jpg?ga=GA1.1.26211853.1698242772&semt=ais_hybrid', // Replace with actual doctor image URL
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Find Your Doctor',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
        ),

        drawer: Drawer(
          child: UserDrawerData(),
        ),

        body: Container(
          color: Colors.grey[100], // Light background for contrast
          child: ListView(
            padding: EdgeInsets.all(10),
            children: [
              _buildCategoryIcons(),
              SizedBox(height: 20),
              ...doctors.map((doctor) {
                return DoctorCard(
                  name: doctor['name']!,
                  category: doctor['category']!,
                  description: doctor['description']!,
                  imageUrl: doctor['imageUrl']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorAppointmentPage(
                          name: doctor['name']!,
                          category: doctor['category']!,
                          description: doctor['description']!,
                          imageUrl: doctor['imageUrl']!,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build medical category icons
  Widget _buildCategoryIcons() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _categoryIcon(Icons.favorite, 'Heart'),
          _categoryIcon(Icons.kitchen, 'Kidney'),
          _categoryIcon(Icons.toys, 'Teeth'),
          _categoryIcon(Icons.hearing, 'Ears'),
          _categoryIcon(Icons.boy_outlined, 'Brain'),
          _categoryIcon(Icons.accessible, 'Bones'),
          _categoryIcon(Icons.local_hospital, 'Eye'),
          _categoryIcon(Icons.face, 'Skin'),
        ],
      ),
    );
  }

  // Widget to create a circular category icon with label
  Widget _categoryIcon(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.indigoAccent,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          SizedBox(height: 5),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final String imageUrl;
  final VoidCallback onTap;

  const DoctorCard({
    required this.name,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(imageUrl),
                onBackgroundImageError: (_, __) {
                  Icon(Icons.person, size: 40, color: Colors.grey);
                },
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      category,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

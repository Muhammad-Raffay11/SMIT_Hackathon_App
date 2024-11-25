import 'package:flutter/material.dart';

// User model class
class User {
  final String name;
  final String email;
  final String uid;

  User({required this.name, required this.email, required this.uid});
}

class ManageUsersPage extends StatelessWidget {
  // Sample data (replace with data fetched from a database or API)
  final List<User> users = [
    User(name: 'John Doe', email: 'john.doe@example.com', uid: 'uid123'),
    User(name: 'Jane Smith', email: 'jane.smith@example.com', uid: 'uid124'),
    User(name: 'Alice Johnson', email: 'alice.johnson@example.com', uid: 'uid125'),
    User(name: 'Bob Brown', email: 'bob.brown@example.com', uid: 'uid126'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Manage Users'),
          centerTitle: true,
          backgroundColor: Colors.indigoAccent,
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return UserCard(user: user);
          },
        ),
      ),
    );
  }
}

// User Card Widget to display individual user info
class UserCard extends StatelessWidget {
  final User user;

  const UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(Icons.person, size: 40, color: Colors.indigo),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Email: ${user.email}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'UID: ${user.uid}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[800],
                    ),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ManageUsersPage(),
  ));
}

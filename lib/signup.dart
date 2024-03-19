import 'package:flutter/material.dart';
import 'package:innowah/login.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 70.0), // Adding space above the text
              // Welcome Text
              Text(
                "Hello! Register to get Started",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF243D3A),
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              // Username Textbox
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Username',
                      filled: true,
                      fillColor: Color(0xFFF7F8F9), // Change to grey
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Round edges
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.0),
              // Email Textbox
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 0.0),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Color(0xFFF7F8F9), // Change to grey
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Round edges
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.0),
              // Password Textbox
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 0.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Color(0xFFF7F8F9), // Change to grey
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Round edges
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 0.0),
              // Confirm Password Textbox
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Confirm Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 0.0),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm password',
                      filled: true,
                      fillColor: Color(0xFFF7F8F9), // Change to grey
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0), // Round edges
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              // Signup Button
              Container(
                width: double.infinity, // Full width
                height: 60.0, // Adjusted height
                child: ElevatedButton(
                  onPressed: () {
                    // Add your signup logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3A4F3B), // Slightly darker blue
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Round edges
                    ),
                  ),
                  child: Text(
                    'Register!',
                    style: TextStyle(
                      color: Colors.white, // Change the color to white
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              // Already have an account Text
              GestureDetector(
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                  // Add logic for navigating to login page
                },
                child: Text(
                  "Already have an account? Log in",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
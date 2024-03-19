import 'package:flutter/material.dart';
import 'package:innowah/homepage.dart';
import 'package:innowah/signup.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      body: Stack(
        children: [
          // Login Form
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Welcome Text
                  Text(
                    "Welcome Back!\nGlad to see you again!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF243D3A),
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 30.0),
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
                      SizedBox(height: 20.0),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Enter your email',
                          filled: true,
                          fillColor: Color(0xFFF7F8F9), // Change to grey
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Round edges
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.0),
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
                      SizedBox(height: 8.0),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Enter your password',
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
                  // Forgot Password Text
                  GestureDetector(
                    onTap: () {
                      // Add logic for forgot password here
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Color(0xFF86AD88),
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login Button
                  Container(
                    width: double.infinity, // Full width
                    height: 60.0, // Adjusted height
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your login logic here
                        // Navigate to home page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF3A4F3B), // Slightly darker blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Round edges
                        ),
                      ),
                      child: Text(
                        'Log me in!',
                        style: TextStyle(
                          color: Colors.white, // Change the color to white
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  // Sign Up Text
                  GestureDetector(
                    onTap: () {
                      // Add logic for sign up here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: Text(
                      "Don't have an account? Sign up",
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
        ],
      ),
    );
  }
}

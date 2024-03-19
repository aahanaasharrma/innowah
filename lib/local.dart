import 'package:flutter/material.dart';
import 'document.dart';

void main() {
  runApp(LocalBusinessPage());
}

class LocalBusinessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 20.0), // Added padding to bring down "Local Business"
                color: Color(0xFFB0C7A6), // Green background color
                child: Center(
                  child: Text(
                    '      Local \n Businesses',
                    style: TextStyle(
                      color: Color(0xFF3A4F3B),
                      fontSize: 40.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30.0), // Space between "Local Business" and "Our Partners"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Our Partners',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.0), // Space between "Our Partners" text and images
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    PartnerList(),
                    SizedBox(height: 10.0), // Space between "Our Partners" and the clickable text
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DocumentVerificationPage()),
                        );
                        // Handle click action here
                      },
                      child: Text(
                        'Are you a local business? Apply here',
                        style: TextStyle(
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                          color: Colors.black, // Set the text color to black
                        ),
                        textAlign: TextAlign.center, // Center align the text
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFB0C7A6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.menu,size:35, color: Colors.black),
              onPressed: () {

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocumentVerificationPage()),
                );
                // Handle menu button press
              },
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }
}

class PartnerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PartnerRow(
          partner1Image: 'assets/images/green.png',
          partner2Image: 'assets/images/Fair.png',
        ),
        SizedBox(height: 20.0), // Space between image rows
        PartnerRow(
          partner1Image: 'assets/images/spoon.png',
          partner2Image: 'assets/images/leaves.png',
        ),
        SizedBox(height: 20.0), // Space between image rows
        PartnerRow(
          partner1Image: 'assets/images/lotus.png',
          partner2Image: 'assets/images/wyld.png',
        ),
        SizedBox(height: 20.0), // Space between image rows
        PartnerRow(
          partner1Image: 'assets/images/veg.png',
          partner2Image: 'assets/images/food.png',
        ),
        SizedBox(height: 20.0), // Space between image rows
      ],
    );
  }
}

class PartnerRow extends StatelessWidget {
  final String partner1Image;
  final String partner2Image;

  PartnerRow({required this.partner1Image, required this.partner2Image});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            elevation: 2, // Set elevation for the shadow
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  partner1Image,
                  width: double.infinity,
                  height: 140.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            elevation: 2, // Set elevation for the shadow
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              margin: EdgeInsets.only(left: 10.0, bottom: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  partner2Image,
                  width: double.infinity,
                  height: 140.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

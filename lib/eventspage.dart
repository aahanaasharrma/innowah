import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_home.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50), // Added padding on top
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome Sarah',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20), // Increased space
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Events',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20), // Increased space
            Expanded(
              child: ListView(
                children: <Widget>[
                  EventCard(
                    title: 'Marathon',
                    date: 'WED, FEB 28 - 8:00 AM',
                    imagePath: 'assets/images/marathon.png',
                    joinedCount: 25,
                  ),SizedBox(height: 30),
                  EventCard(
                    title: 'Sustainable Gardening Class',
                    date: 'FRI, MAR 1 - 8:00 PM',
                    imagePath: 'assets/images/gardening.png',
                    joinedCount: 0,
                    isEcoPointEvent: true,
                  ),
                  // Add more EventCard widgets as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String imagePath;
  final int joinedCount;
  final bool isEcoPointEvent;

  const EventCard({
    required this.title,
    required this.date,
    required this.imagePath,
    this.joinedCount = 0,
    this.isEcoPointEvent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Increased margin
      color: Colors.white, // Set background color to white
      child: Column(
        children: <Widget>[
          Image.asset(
            imagePath,
            width: double.infinity, // Make image fit the width of the box
            fit: BoxFit.cover, // Adjust the image to cover the box
          ),
          ListTile(
            title: Text(title),
            subtitle: Text(date),
            trailing: isEcoPointEvent
                ? ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFB0C7A6)), // Sage green color
              ),
              child: Text(
                'Redeem EcoPoints',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            )
                : ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFB0C7A6)), // Sage green color
              ),
              child: Text(
                'Join now',
                style: TextStyle(color: Colors.white), // Set text color to white
              ),
            ),
          ),
          if (joinedCount > 0) ...[
            Row(
              children: <Widget>[
                // Add your joined user profile images here
                Text('+${joinedCount} joined'),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

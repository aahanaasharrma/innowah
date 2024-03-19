import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFB0C7A6), // Sage green color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Text('Profile'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Handle log out
            },
            child: Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          _buildProfileHeader(),
          _buildPointHistory(),
          // ... Add other widget components if necessary
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('700 pts', style: TextStyle(color: Colors.white)),
              TextButton(
                onPressed: () {
                  // Handle history press
                },
                child: Text('History', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
          SizedBox(height: 10),
          CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage('assets/images/profile_image.png'),
          ),
          SizedBox(height: 10),
          Text(
            'Sarah W.',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          Text(
            'Mindful choices, passionate voices.',
            style: TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildPointHistory() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color(0xFFB0C7A6), // Sage green color
          width: 2.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Point History',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10), // Increased spacing between header and list
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: Text('Cycling Route taken'),
            subtitle: Text('Today, 4:32 PM'),
            trailing: Text('+75'),
          ),
          SizedBox(height: 10), // Increased spacing between list items
          ListTile(
            leading: Icon(Icons.local_dining),
            title: Text('VegBites Salad'),
            subtitle: Text('Today, 9:00 AM'),
            trailing: Text('-200'),
          ),
          SizedBox(height: 10), // Increased spacing between list items
          ListTile(
            leading: Icon(Icons.train),
            title: Text('Local Train utilized'),
            subtitle: Text('Yesterday, 8:30 PM'),
            trailing: Text('+55'),
          ),
          SizedBox(height: 10), // Increased spacing between list items
          ListTile(
            leading: Icon(Icons.directions_walk),
            title: Text('Synced your daily steps'),
            subtitle: Text('Yesterday, 4:30 PM'),
            trailing: Text('+25'),
          ),
          // ... Add more ListTiles for each point history entry
        ],
      ),
    );
  }
}

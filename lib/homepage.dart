import 'package:flutter/material.dart';
import 'package:innowah/aboutus.dart';
import 'package:innowah/carbonpage.dart';
import 'package:innowah/cycle_route.dart';
import 'package:innowah/eventspage.dart';
import 'package:innowah/local.dart';
import 'package:innowah/news.dart';
import 'package:innowah/profilepage.dart';
import 'package:innowah/rentals_page.dart';
import 'package:innowah/rewards_page.dart'; // Ensure this is created
import 'package:innowah/signup.dart';

import 'car_route.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) { // Assumes "Rewards" is at index 1
      Navigator.push(context, MaterialPageRoute(builder: (context) => RewardsPage()));
    } else if (index == 3) { // Assumes "Profile" is at index 3
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    // Add navigation for other indices if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null,
        backgroundColor: Color(0xFFB0C7A6),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40.0),
          child: Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.0),
                Text(
                  'Location:',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Chennai, India',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: SideMenu(),
      body: Stack(
        children: [
          BackgroundImage(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Let's do our part for a better future",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SliderWidget(),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainSquareButton(
                      title: 'Carpooling',
                      icon: 'carpool.png',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CarRoute()));
                      },
                    ),
                    SizedBox(width: 40),
                    MainSquareButton(
                      title: 'Rentals',
                      icon: 'rentals.png',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RentalsPage()));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MainSquareButton(
                      title: 'Train Schedule',
                      icon: 'train.png',
                      onPressed: () {
                        // Implement navigation or functionality
                      },
                    ),
                    SizedBox(width: 40),
                    MainSquareButton(
                      title: 'Events',
                      icon: 'events.png',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EventsPage()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/home.jpg')),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/rewards.jpg')),
            label: 'Rewards',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/chatbot.jpg')),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/profile.jpg')),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

// Include your existing SliderWidget, BackgroundImage, MainSquareButton, and SideMenu class definitions below this line.

// Include your existing SliderWidget, BackgroundImage, MainSquareButton, and SideMenu class definitions below this line.

class SliderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Daily Eco Points',
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFB0C7A6), // Sage green color
            ),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                '0', // Start of slider
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFB0C7A6), // Sage green color
                ),
              ),
              Expanded(
                child: Slider(
                  value: 62.5, // Halfway through the slider
                  min: 0,
                  max: 125, // End of slider
                  onChanged: (value) {
                    // Handle slider value change
                  },
                  activeColor: Color(0xFFB0C7A6), // Sage green color
                ),
              ),
              Text(
                '125', // End of slider
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFB0C7A6), // Sage green color
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_home.png'), // Updated path
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MainSquareButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onPressed;

  const MainSquareButton({
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 175, // Increased button width
      height: 175, // Increased button height
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/$icon',
              width: 125, // Adjusted icon size
              height: 105,
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18, // Adjusted text size
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB0C7A6), // Sage green color
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/profile.jpg'),
                ),
                SizedBox(height: 10),
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('About Us'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()));
            },
          ),
          ListTile(
            title: Text('Carbon Footprint'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarbonPage()));
            },
          ),
          ListTile(
            title: Text('Cycling Routes'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CycleRoute()));
            },
          ),
          ListTile(
            title: Text('EcoNews'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsPage()));
            },
          ),
          ListTile(
            title: Text('Local Businesses'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LocalBusinessPage()));
            },
          ),
        ],
      ),
    );
  }
}

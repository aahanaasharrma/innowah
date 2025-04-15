import 'package:flutter/material.dart';
import 'package:innowah/Presentation/Screen/HomePage/carpool/carpool.dart';
import 'package:innowah/Presentation/Screen/HomePage/eventspage.dart';
import 'package:innowah/Presentation/Screen/BottomNav/profilepage.dart';
import 'package:innowah/Presentation/Screen/HomePage/rentals_page.dart';
import 'package:innowah/Presentation/Screen/BottomNav/rewards_page.dart';
import 'package:innowah/Presentation/Screen/BottomNav/step.dart';
import 'Presentation/Screen/HomePage/train.dart';
import 'Presentation/Widgets/bgimage.dart';
import 'Presentation/Widgets/sidebar.dart';
import 'Presentation/Widgets/slider.dart';

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

    if (index == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => RewardScreen()));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
    else if (index == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => StepCounter()));
    }

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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CarpoolScreen()));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TrainSearchScreen()));
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
    label: 'Steps',
    ),
    BottomNavigationBarItem(
    icon: ImageIcon(AssetImage('assets/images/profile.jpg')),
    label: 'Profile',
    ),
    ],
    currentIndex: _selectedIndex,
    onTap: _onItemTapped,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.grey,
    unselectedItemColor: Colors.grey,
    showSelectedLabels: true,
    showUnselectedLabels: true,
      ),);
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

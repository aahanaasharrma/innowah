
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Screen/SideBar/aboutus.dart';
import '../Screen/SideBar/carbonpage.dart';
import '../Screen/SideBar/leaderboard.dart';
import '../Screen/SideBar/LocalBuisness/local.dart';
import '../Screen/SideBar/news.dart';
import '../Screen/Daily_Journal/daily_log.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFB0C7A6),
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
                  'Devangana',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            title: Text('Daily Log'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => JournalPage()));
            },
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
          ListTile(
            title: Text('LeaderBoard'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LeaderboardScreen()));
            },
          ),
        ],
      ),
    );
  }
}

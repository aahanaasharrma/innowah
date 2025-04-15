import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:innowah/Presentation/Screen/HomePage/carpool/schedule_ride.dart';
import 'package:innowah/Presentation/Screen/HomePage/carpool/search.dart';

import '../../../../Services/firebase_service.dart';
import '../../../../Services/model.dart';
import 'inbox.dart';
 // Import the InboxPage

class CarpoolScreen extends StatefulWidget {
  @override
  _CarpoolScreenState createState() => _CarpoolScreenState();
}

class _CarpoolScreenState extends State<CarpoolScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: Color(0xFFAEC6A5),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Center(
              child: Text(
                'CarPool',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A4F3B),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          TabBar(
            controller: _tabController,
            indicatorColor: Color(0xFFB0C7A6),
            tabs: [
              _buildTab('Search'),
              _buildTab('Publish'),
              _buildTab('Inbox'),
            ],
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                SearchRidesPage(),
                ScheduleRidePage(),
                InboxPage(),  // Call the InboxPage here
              ],
            ),
          ),
        ],
      ),
    );
  }

  Tab _buildTab(String text) {
    return Tab(
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: CarpoolScreen(),
  ));
}

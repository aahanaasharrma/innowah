import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  final List<Map<String, dynamic>> users = [
    {'name': 'Alice', 'carbonFootprint': 10},
    {'name': 'Bob', 'carbonFootprint': 15},
    {'name': 'Charlie', 'carbonFootprint': 20},
    {'name': 'David', 'carbonFootprint': 25},
    {'name': 'Eve', 'carbonFootprint': 30},
  ];

  final List<Color> medalColors = [
    Color(0xFFFFD700),
    Color(0xFFC0C0C0), // Silver for 2nd place
    Color(0xFFCD7F32), // Bronze for 3rd place
  ];

  @override
  Widget build(BuildContext context) {
    users.sort((a, b) => a['carbonFootprint'].compareTo(b['carbonFootprint']));

    return Scaffold(
      body: Column(
        children: [
          // Leaderboard Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 50),
            decoration: BoxDecoration(
              color: Color(0xFFAEC6A5),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
            ),
            child: Center(
              child: Text(
                '🏆 Leaderboard 🏆',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3A4F3B),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Leaderboard List
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      colors: [Color(0xFFB0C7A6), Color(0xFFAEC6A5)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    leading: CircleAvatar(
                      backgroundColor: index < 3 ? medalColors[index] : Color(0xFFB0C7A6),
                      child: index < 3
                          ? Icon(Icons.emoji_events, color: Colors.white, size: 24)
                          : Text((index + 1).toString(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    title: Text(
                      users[index]['name'],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    subtitle: Text(
                      'Carbon Footprint: ${users[index]['carbonFootprint']} kg CO₂',
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                    trailing: CircleAvatar(
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=${index + 1}'),
                    ),

                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LeaderboardScreen(),
  ));
}

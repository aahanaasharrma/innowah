import 'package:flutter/material.dart';
import 'package:innowah/schedule_ride.dart';

class CarpoolScreen extends StatefulWidget {
  @override
  _CarpoolScreenState createState() => _CarpoolScreenState();
}

class _CarpoolScreenState extends State<CarpoolScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int pricePerSeat = 10;
  int no = 1;

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
                _buildSearchContent(),
                _buildPublishContent(),
                _buildInboxContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Expanded(
          child: ScheduleRidePage(),
        ),
      ],
    );
  }


  Widget _buildPublishContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.0),
          Text(
            'Set Your Price per Seat',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB0C7A6),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      pricePerSeat++;
                    });
                  },
                  iconSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 40),
              Text(
                'Rs $pricePerSeat',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 40),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB0C7A6),
                ),
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (pricePerSeat > 0) pricePerSeat--;
                    });
                  },
                  iconSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 30),
            ],
          ),
          SizedBox(height: 20.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color:  Color(0xFFB0C7A6),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              'Recommended price: Rs. 60 - Rs. 80',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Number of Passengers',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 20),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB0C7A6),
                ),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      no++;
                    });
                  },
                  iconSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 40),
              Text(
                ' $no',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 40),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFB0C7A6),
                ),
                child: IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (no > 0) no--;
                    });
                  },
                  iconSize: 40,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 30),
            ],
          ),

          Image.asset(
            'assets/images/carpool.png',
            width:400,
            height: 300,
          ),
        ],
      ),
    );
  }

  Widget _buildInboxContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        SizedBox(height: 20),
        Image.asset(
          'assets/images/inbox.png',
          width: 400,
          height: 200,
            fit: BoxFit.contain,
        ),

      ],
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
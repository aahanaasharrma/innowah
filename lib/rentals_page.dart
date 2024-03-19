import 'package:flutter/material.dart';

class RentalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu), // Assuming you have a menu button here.
        title: Text('Rentals'),
        actions: <Widget>[
          CircleAvatar(
            // Replace with your user's profile image asset
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          SizedBox(width: 10), // For padding
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Find a Cycle or an Electric Scooter near you',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: Text(
                'Have a very pleasant experience',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Find cycle, etc',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _categoryButton(label: 'Cycles'),
                  _categoryButton(label: 'Electric Vehicles'),
                  _categoryButton(label: 'Routes'),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RentalItem(
                      key: ValueKey('Sai Cycle Rental'), // Unique key based on the title
                      title: 'Sai Cycle Rental',
                      distance: '12m away',
                      price: 'Rs. 25 per hour',
                      imageUrl: 'assets/images/cycle1.png',
                      boxColor: Color(0xFFB0C7A6), // Sage green color
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RentalItem(
                      key: ValueKey('Raja Rentals'), // Unique key based on the title
                      title: 'Raja Rentals',
                      distance: '10m away',
                      price: 'Rs. 35 per hour',
                      imageUrl: 'assets/images/cycle2.png',
                      boxColor: Color(0xFFB0C7A6), // Sage green color
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Accessories',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AccessoryItem(
                title: 'Black and white helmet MT',
                subtitle: 'Scooter, bike',
                price: 'Rs. 856',
                imageUrl: 'assets/images/helmet.png', // Replace with your asset
                boxColor: Color(0xFFB0C7A6), // Sage green color
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryButton({required String label}) {
    return ElevatedButton(
      onPressed: () {
        // Handle your category change
      },
      child: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Color(0xFFB0C7A6), // Sage green color
      ),
    );
  }
}

class RentalItem extends StatelessWidget {
  final String title;
  final String distance;
  final String price;
  final String imageUrl;
  final Color boxColor;

  const RentalItem({
    Key? key,
    required this.title,
    required this.distance,
    required this.price,
    required this.imageUrl,
    required this.boxColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: boxColor, // Set the color of the box
      child: SizedBox(
        width: 200, // Set a fixed width for each item
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imageUrl,
              height: 150, // Set a fixed height for the image
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(distance),
                  SizedBox(height: 4),
                  Text(price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccessoryItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String imageUrl;
  final Color boxColor;

  const AccessoryItem({
    Key? key, // Key should be optional
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.boxColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: boxColor, // Set the color of the box
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Image.asset(
              imageUrl,
              width: 100, // Set a fixed width for the image
              height: 60, // Set a fixed height for the image
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: Color(0xFFB0C7A6), // Sage green color
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Add your onPressed handler here
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Color(0xFFB0C7A6), // Sage green color
              ),
              child: Text('Buy now'),
            ),
          ],
        ),
      ),
    );
  }
}

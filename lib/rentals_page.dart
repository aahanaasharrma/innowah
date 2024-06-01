import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:http/http.dart' as http;
import 'dart:convert';

class RentalsPage extends StatefulWidget {
  @override
  _RentalsPageState createState() => _RentalsPageState();
}

class _RentalsPageState extends State<RentalsPage> {
  List<dynamic> _rentalShops = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRentalShops();
  }

  Future<void> _fetchRentalShops() async {
    try {
      location.Location loc = location.Location();
      location.LocationData locationData = await loc.getLocation();
      final apiKey = 'AIzaSyDP1HbV7FDh1RkCowbOLsnA9Al0lgmFWpQ';
      final latitude = locationData.latitude;
      final longitude = locationData.longitude;
      final radius = 5000; // 5000 meters (5 km) radius
      final types = 'car_rental|bicycle_store'; // Add more types as needed
      final url =
          'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&types=$types&key=$apiKey';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _rentalShops = data['results'];
        });
      } else {
        throw Exception('Failed to fetch rental shops');
      }
    } catch (e) {
      print('Error fetching rental shops: $e');
    }
  }

  List<dynamic> _searchRentalShops(String query) {
    return _rentalShops.where((shop) {
      final name = shop['name'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD1E2C9),
        title: Text('Nearby Rentals', style: TextStyle(color: Colors.black)),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: _searchController.text.isEmpty
                ? _buildRentalList(_rentalShops)
                : _buildRentalList(_searchRentalShops(_searchController.text)),
          ),
        ],
      ),
    );
  }

  Widget _buildRentalList(List<dynamic> rentals) {
    return rentals.isEmpty
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: rentals.length,
      itemBuilder: (context, index) {
        final shop = rentals[index];
        final name = shop['name'];
        final placeId = shop['place_id'];
        return FutureBuilder(
          future: _getPhotoUrl(placeId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListTile(
                title: Text(name),
                subtitle: Text('Loading...'),
              );
            } else if (snapshot.hasError) {
              return ListTile(
                title: Text(name),
                subtitle: Text('Error loading photo'),
              );
            } else {
              final photoUrl = snapshot.data as String?;
              return ListTile(
                title: Text(name),
                subtitle: photoUrl != null ? Image.network(photoUrl) : Text('No photo available'),
              );
            }
          },
        );
      },
    );
  }

  Future<String?> _getPhotoUrl(String placeId) async {
    try {
      final apiKey = 'AIzaSyDP1HbV7FDh1RkCowbOLsnA9Al0lgmFWpQ';
      final url =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=photo&key=$apiKey';
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final photoRef = data['result']['photos'][0]['photo_reference'];
        return 'https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=$photoRef&key=$apiKey';
      } else {
        throw Exception('Failed to fetch photo for place: $placeId');
      }
    } catch (e) {
      print('Error fetching photo: $e');
      return null;
    }
  }
}

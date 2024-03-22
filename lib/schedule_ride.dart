import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';

import 'car_route.dart';

class ScheduleRidePage extends StatefulWidget {
  @override
  _ScheduleRidePageState createState() => _ScheduleRidePageState();
}

class _ScheduleRidePageState extends State<ScheduleRidePage> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      location.Location loc = location.Location();
      location.LocationData locationData = await loc.getLocation();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        locationData.latitude!,
        locationData.longitude!,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String street = placemark.street ?? '';
        String locality = placemark.locality ?? '';
        String administrativeArea = placemark.administrativeArea ?? '';
        String postalCode = placemark.postalCode ?? '';
        String country = placemark.country ?? '';
        String formattedAddress =
            '$street, $locality, $administrativeArea $postalCode, $country';
        setState(() {
          _fromController.text = formattedAddress;
        });
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Ride'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Schedule Ride',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'From',
              ),
              readOnly: true,
              controller: _fromController,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _toController,
              decoration: InputDecoration(
                labelText: 'To',
                hintText: 'Set your destination',
              ),
              // Add onTap if you want to select the location
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CarRoute(destination: _toController.text),
                  ),
                );
              },
              child: Text('Schedule'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart' as intl;

import 'car_route.dart';

class ScheduleRidePage extends StatefulWidget {
  @override
  _ScheduleRidePageState createState() => _ScheduleRidePageState();
}

class _ScheduleRidePageState extends State<ScheduleRidePage> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  int _numberOfPeople = 1;

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        _dateController.text = intl.DateFormat('yyyy-MM-dd').format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/car.png',
            height: 300, // Adjust size as needed
            width: 300, // Adjust size as needed
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[200], // Light grey color
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
                      labelText: 'Leaving From',
                    ),
                    readOnly: true,
                    controller: _fromController,
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _toController,
                    decoration: InputDecoration(
                      labelText: 'Going To',
                      hintText: 'Set your destination',
                    ),
                    // Add onTap if you want to select the location
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      labelText: 'Date',
                      hintText: 'Select Date',
                      suffixIcon: IconButton(
                        onPressed: () => _selectDate(context),
                        icon: Icon(Icons.calendar_today),
                      ),
                    ),
                    readOnly: true,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Number of People: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButton<int>(
                        value: _numberOfPeople,
                        onChanged: (int? newValue) {
                          setState(() {
                            _numberOfPeople = newValue!;
                          });
                        },
                        items: <int>[1, 2, 3, 4, 5]
                            .map<DropdownMenuItem<int>>((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CarRoute(destination: _toController.text),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3A4F3B), // Button color
                    ),
                    child: Text(
                      'Schedule',
                      style: TextStyle(
                        color: Colors.white, // Text color
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
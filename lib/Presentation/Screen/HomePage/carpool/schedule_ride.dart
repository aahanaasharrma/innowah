import 'package:flutter/material.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../Services/firebase_service.dart';
import '../../../../Services/model.dart';
import 'car_route.dart';

class ScheduleRidePage extends StatefulWidget {
  @override
  _ScheduleRidePageState createState() => _ScheduleRidePageState();
}

class _ScheduleRidePageState extends State<ScheduleRidePage> {
  TextEditingController _fromController = TextEditingController();
  TextEditingController _toController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;
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
        String formattedAddress =
            '${placemark.street ?? ''}, ${placemark.locality ?? ''}, ${placemark.administrativeArea ?? ''} ${placemark.postalCode ?? ''}, ${placemark.country ?? ''}';
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
      initialDate: DateTime.now().add(Duration(hours: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = intl.DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            'assets/images/car.png',
            height: 300,
            width: 300,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Publish Ride',
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
                      final from = _fromController.text.trim();
                      final to = _toController.text.trim();

                      if (from.isEmpty || to.isEmpty || _selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please fill all the details")),
                        );
                        return;
                      }

                      final ride = Ride(
                        id: '', // leave empty to auto-generate ID
                        departureLocation: from,
                        destination: to,
                        departureTime: _selectedDate!, // This is a DateTime, it will be converted to Timestamp in FirebaseService

                        status: 'Published',
                        matched: false,
                      );

                      FirebaseService().publishRide(ride);
                      FirebaseService().matchRides(ride); // Assuming you have logic to match rides

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CarRoute(destination: to),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3A4F3B),
                    ),
                    child: Text(
                      'Publish Ride',
                      style: TextStyle(color: Colors.white),
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

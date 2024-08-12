import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Train {
  final String trainNumber;
  final String trainName;
  final List<String> runDays;
  final String fromStationCode;
  final String toStationCode;
  final String fromStationName;
  final String toStationName;
  final String duration;
  final bool specialTrain;
  final String trainType;
  final String trainDate;
  final List<String> classType;
  final String arrivalTime;
  final String departureTime;
  final String startTime; // New field for start time
  final String endTime; // New field for end time

  Train({
    required this.trainNumber,
    required this.trainName,
    required this.runDays,
    required this.fromStationCode,
    required this.toStationCode,
    required this.fromStationName,
    required this.toStationName,
    required this.duration,
    required this.specialTrain,
    required this.trainType,
    required this.trainDate,
    required this.classType,
    required this.arrivalTime,
    required this.departureTime,
    required this.startTime,
    required this.endTime,
  });

  factory Train.fromJson(Map<String, dynamic> json) {
    return Train(
      trainNumber: json['train_number'] ?? '',
      trainName: json['train_name'] ?? '',
      runDays: List<String>.from(json['run_days'] ?? []),
      fromStationCode: json['from_sta'] ?? '',
      toStationCode: json['to_sta'] ?? '',
      fromStationName: json['from_station_name'] ?? '',
      toStationName: json['to_station_name'] ?? '',
      duration: json['duration'] ?? '',
      specialTrain: json['special_train'] ?? false,
      trainType: json['train_type'] ?? '',
      trainDate: json['train_date'] ?? '',
      classType: List<String>.from(json['class_type'] ?? []),
      arrivalTime: json['arrival_time'] ?? '',
      departureTime: json['departure_time'] ?? '',
      startTime: json['from_std'] ?? '',
      endTime: json['to_std'] ?? '',
    );


  }
}

class TrainSearchScreen extends StatefulWidget {
  @override
  _TrainSearchScreenState createState() => _TrainSearchScreenState();
}

class _TrainSearchScreenState extends State<TrainSearchScreen> {
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<Train> _trains = [];
  bool _isLoading = false;

  Future<void> _fetchTrains(String fromStationCode, String toStationCode, String dateOfJourney) async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.https('irctc1.p.rapidapi.com', '/api/v3/trainBetweenStations', {
      'fromStationCode': fromStationCode,
      'toStationCode': toStationCode,
      'dateOfJourney': dateOfJourney,
    });

    final headers = {
      'X-RapidAPI-Key': '6eac665157mshe8ae90f1020c6d1p1ee884jsn4e1f0df85651',
      'X-RapidAPI-Host': 'irctc1.p.rapidapi.com',
    };

    try {
      final response = await http.get(url, headers: headers);
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final dynamic responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'] ?? [];
        setState(() {
          _trains = data.map((train) => Train.fromJson(train ?? {})).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load trains. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // No appbar
      backgroundColor: Color(0xFFFFFFFF), // Light green for bottom half
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFB0C7A6), // Light green
                  Color(0xFF3A4F3B), // Dark green
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Track  your  train',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6), // Shadow color with opacity
                          spreadRadius: 5, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: Offset(1, 3), // Offset in x and y direction
                        ),
                      ], // Rounded corners
                    ),
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _fromController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200], // Light grey fill
                            hintText: 'Enter From Station',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none, // Remove border side
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Text(
                            'TO',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF243D3A),
                              fontSize: 20,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: _toController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200], // Light grey fill
                            hintText: 'Enter To Station',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none, // Remove border side
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200], // Light grey fill
                            hintText: 'Enter Date of Journey (YYYY-MM-DD)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none, //
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            width: 250,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle search functionality
                                _fetchTrains(
                                  _fromController.text.trim(),
                                  _toController.text.trim(),
                                  _dateController.text.trim(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF3A4F3B), // Dark green color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 0,
                                ), // Adjusted padding
                              ),
                              child: Text(
                                'Search Trains',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                color: Colors.white, // White color for bottom half
                padding: EdgeInsets.all(16),
                child: _isLoading
                    ? CircularProgressIndicator()
                    : ListView.builder(
                  itemCount: _trains.length,
                  itemBuilder: (context, index) {
                    final train = _trains[index];
                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              train.trainName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    'PNR No: ${train.trainNumber}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Start Time: ${train.startTime}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'End Time: ${train.endTime}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )

            ),
          ),
        ],
      ),
    );
  }
}
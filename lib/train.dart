import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  final String startTime;
  final String endTime;

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

    final apiKey = dotenv.env['RAPIDAPI_KEY'];
    final url = Uri.https('irctc1.p.rapidapi.com', '/api/v3/trainBetweenStations', {
      'fromStationCode': fromStationCode,
      'toStationCode': toStationCode,
      'dateOfJourney': dateOfJourney,
    });

    final headers = {
      'X-RapidAPI-Key': apiKey!,
      'X-RapidAPI-Host': 'irctc1.p.rapidapi.com',
    };

    try {
      final response = await http.get(url, headers: headers);
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
      appBar: null,
      backgroundColor: Color(0xFFFFFFFF),
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
                colors: [Color(0xFFB0C7A6), Color(0xFF3A4F3B)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  Text('Track Your Train', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextField(controller: _fromController, decoration: InputDecoration(hintText: 'From Station')),
                  TextField(controller: _toController, decoration: InputDecoration(hintText: 'To Station')),
                  TextField(controller: _dateController, decoration: InputDecoration(hintText: 'Date (YYYY-MM-DD)')),
                  ElevatedButton(
                    onPressed: () {
                      _fetchTrains(
                        _fromController.text.trim(),
                        _toController.text.trim(),
                        _dateController.text.trim(),
                      );
                    },
                    child: Text('Search Trains'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: _trains.length,
              itemBuilder: (context, index) {
                final train = _trains[index];
                return ListTile(
                  title: Text(train.trainName),
                  subtitle: Text('From: ${train.fromStationName} - To: ${train.toStationName}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

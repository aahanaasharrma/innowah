import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarRoute extends StatefulWidget {
  final String destination;

  CarRoute({required this.destination});

  @override
  _CarRouteState createState() => _CarRouteState();
}

class _CarRouteState extends State<CarRoute> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  location.LocationData? _currentLocation;
  late Polyline _routePolyline;

  @override
  void initState() {
    super.initState();
    _routePolyline = Polyline(polylineId: PolylineId('route'));
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      location.Location loc = location.Location();
      location.LocationData locationData = await loc.getLocation();
      setState(() {
        _currentLocation = locationData;
        _addMarker(LatLng(locationData.latitude!, locationData.longitude!));
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> _getDestinationCoordinates(String destination) async {
    List<Location> locations = await locationFromAddress(destination);
    if (locations.isNotEmpty) {
      Location destinationLocation = locations[0];
      _addMarker(LatLng(
        destinationLocation.latitude,
        destinationLocation.longitude,
      ));
      _plotRoute(_currentLocation!.latitude!, _currentLocation!.longitude!,
          destinationLocation.latitude, destinationLocation.longitude);
    }
  }

  void _addMarker(LatLng position) async {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId("currentLocation"),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  void _plotRoute(double fromLat, double fromLng, double toLat, double toLng) async {
    final apiKey = 'AIzaSyDP1HbV7FDh1RkCowbOLsnA9Al0lgmFWpQ';
    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$fromLat,$fromLng&destination=$toLat,$toLng&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'];
      if (routes != null && routes.isNotEmpty) {
        final points = _decodePolyline(routes[0]['overview_polyline']['points']);
        print("Polyline points: $points"); // Print polyline data for debugging
        _addPolylineToMap(points);
      }
    }
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }

  void _addPolylineToMap(List<LatLng> polylinePoints) {
    setState(() {
      _routePolyline = Polyline(
        polylineId: PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      );
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    _getDestinationCoordinates(widget.destination); // Fetch destination coordinates

    return Scaffold(
      appBar: AppBar(
        title: Text('Carpooling'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            _currentLocation!.latitude!,
            _currentLocation!.longitude!,
          ),
          zoom: 15,
        ),
        markers: _markers,
        polylines: {
          _routePolyline,
        },
        myLocationEnabled: true,
        zoomControlsEnabled: false,
      ),
    );
  }
}

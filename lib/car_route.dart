import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:geocoding/geocoding.dart';

class CarRoute extends StatefulWidget {
  @override
  _CarRouteState createState() => _CarRouteState();
}

class _CarRouteState extends State<CarRoute> {
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  location.LocationData? _currentLocation;
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
      setState(() {
        _currentLocation = locationData;
        _addMarker(LatLng(locationData.latitude!, locationData.longitude!));
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  void _addMarker(LatLng position) async {
    _markers.clear();
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
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
        _toController.text = formattedAddress;
      });
    }

    _markers.add(
      Marker(
        markerId: MarkerId("currentLocation"),
        position: position,
        icon: BitmapDescriptor.defaultMarker,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carpooling'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    _currentLocation!.latitude!,
                    _currentLocation!.longitude!),
                zoom: 15,
              ),
              markers: _markers,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
            ),
          ),
          Container(
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
                  controller: TextEditingController(
                    text: _toController.text,
                  ),
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
                    // Implement your logic to schedule the ride
                  },
                  child: Text('Schedule'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



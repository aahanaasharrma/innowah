import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarRoute extends StatefulWidget {
  @override
  _CarRouteState createState() => _CarRouteState();
}

class _CarRouteState extends State<CarRoute> {
  final LatLng _initialCameraPosition = LatLng(12.94607202950104, 80.20766326931427); // Default location
  final TextEditingController _placeController = TextEditingController();
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {}; // Use a Set for markers to easily manage them

  @override
  void initState() {
    super.initState();
    _addMarker(); // Add the default marker
  }

  void _addMarker() {
    // Adds a marker at the default location
    _markers.add(
      Marker(
        markerId: MarkerId("defaultLocation"),
        position: _initialCameraPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue), // Set marker color to blue
        infoWindow: InfoWindow(title: 'Default Location'), // Optional: Adds an info window on tap
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
        title: Text('Google Maps Marker'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialCameraPosition,
          zoom: 15, // You can adjust the zoom level as needed
        ),
        markers: _markers, // Your Set of markers
        myLocationButtonEnabled: false, // Disables the button to center map on current location
        zoomControlsEnabled: false, // Optionally disable zoom controls
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final MapController _mapController = MapController();

  LatLng? _currentLocation;
  LatLng? _destinationLocation;
  List<LatLng> _routePoints = [];

  String _searchQuery = '';
  String _travelTime = '';
  String _travelDistance = '';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final latLng = LatLng(position.latitude, position.longitude);
    setState(() {
      _currentLocation = latLng;
    });
    _mapController.move(latLng, 15);
  }

  Future<void> _searchPlace(String query) async {
    final url = "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1";
    final response = await http.get(Uri.parse(url), headers: {'User-Agent': 'FlutterMapApp'});

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);
        final destination = LatLng(lat, lon);

        setState(() {
          _destinationLocation = destination;
        });

        _mapController.move(destination, 14);
        await _getRouteAndInfo(destination);
      }
    }
  }

  Future<void> _getRouteAndInfo(LatLng destination) async {
    if (_currentLocation == null) return;

    final url =
        'http://router.project-osrm.org/route/v1/driving/${_currentLocation!.longitude},${_currentLocation!.latitude};${destination.longitude},${destination.latitude}?overview=full&geometries=geojson';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final geometry = data['routes'][0]['geometry']['coordinates'];
      final distance = data['routes'][0]['distance'] / 1000; // in KM
      final duration = data['routes'][0]['duration'] / 60; // in minutes

      List<LatLng> points = geometry
          .map<LatLng>((coord) => LatLng(coord[1], coord[0]))
          .toList();

      setState(() {
        _routePoints = points;
        _travelDistance = distance.toStringAsFixed(2) + ' km';
        _travelTime = duration.toStringAsFixed(1) + ' mins';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Map Route Finder')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search place',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchPlace(_searchQuery),
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => _searchQuery = value,
              onSubmitted: _searchPlace,
            ),
          ),
          if (_travelTime.isNotEmpty && _travelDistance.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Distance: $_travelDistance | ETA: $_travelTime',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: _currentLocation == null
                ? const Center(child: CircularProgressIndicator())
                : FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      center: _currentLocation,
                      zoom: 15,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.multi_localization_app',
                      ),
                      if (_routePoints.isNotEmpty)
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: _routePoints,
                              color: Colors.blue,
                              strokeWidth: 5,
                            )
                          ],
                        ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: _currentLocation!,
                            width: 40,
                            height: 40,
                            child: const Icon(Icons.my_location, size: 40, color: Colors.green),
                          ),
                          if (_destinationLocation != null)
                            Marker(
                              point: _destinationLocation!,
                              width: 40,
                              height: 40,
                              child: const Icon(Icons.location_on, size: 40, color: Colors.red),
                            ),
                        ],
                      ),
                    ],
                  ),
          ),
          Text(_currentLocation!.latitude.toString())
        ],
      ),
    );
  }
}

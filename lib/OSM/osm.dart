import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({super.key});

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final MapController _mapController = MapController();
  LatLng _mapCenter = LatLng(28.6139, 77.2090); // Default: Delhi
  String _searchQuery = '';
  LatLng? _searchedLocation;

  Future<void> _searchPlace(String query) async {
    final url =
        "https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=1";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'User-Agent': 'FlutterMapExampleApp', // Required by OSM
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      if (data.isNotEmpty) {
        final lat = double.parse(data[0]['lat']);
        final lon = double.parse(data[0]['lon']);

        final newLocation = LatLng(lat, lon);

        setState(() {
          _searchedLocation = newLocation;
        });

        _mapController.move(newLocation, 15.0);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Place not found")),
        );
      }
    } else {
      print("Failed to fetch location");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Location'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Place',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _searchPlace(_searchQuery),
                ),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) {
                _searchQuery = value;
              },
              onSubmitted: _searchPlace,
            ),
          ),
          Expanded(
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                center: _mapCenter,
                zoom: 13,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.multi_localization_app',
                ),
                if (_searchedLocation != null)
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40,
                        height: 40,
                        point: _searchedLocation!,
                        child: const Icon(Icons.location_on, size: 40, color: Colors.red),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

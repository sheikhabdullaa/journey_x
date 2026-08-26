import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:journey_x/lib/components/custom_text.dart';
import 'package:journey_x/lib/utils/app_colors.dart';
import 'package:latlong2/latlong.dart';

class GoogleMapscreen extends StatefulWidget {
  const GoogleMapscreen({super.key});

  @override
  State<GoogleMapscreen> createState() => GoogleMapscreenState();
}

final MapController _mapcontroller = MapController();

class GoogleMapscreenState extends State<GoogleMapscreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customtext(text: 'Map', fontSize: 24, color: AppColors.black),
      ),
      body: FlutterMap(
        mapController: _mapcontroller,
        options: const MapOptions(
          initialCenter: LatLng(33.601921, 73.038078),
          initialZoom: 2,
          minZoom: 0,
          maxZoom: 100,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(33.601921, 73.038078),
                child: Icon(Icons.location_pin),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

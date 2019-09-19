import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ShowMap extends StatefulWidget {
  @override
  _ShowMapState createState() => _ShowMapState();
}

class _ShowMapState extends State<ShowMap> {
  static const LatLng centerMap = const LatLng(13.667708, 100.621809);
  CameraPosition cameraPosition = CameraPosition(
    target: centerMap,
    zoom: 16.0,
  );

  LocationData currentLocation;

  @override
  void initState() {
    super.initState();
    findLocation();
  }

  Future<LocationData> locationData() async {
    var location = Location();

    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print('Premission Denied');
      }
      return null;
    }
  }

  Future<void> findLocation() async {
    currentLocation = await locationData();
    print(
        'Lat = ${currentLocation.latitude}, Lng = ${currentLocation.longitude}');
  }

  Widget myMap() {
    return GoogleMap(
      myLocationEnabled: true,
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
      markers: ewtcMarker(),
    );
  }

  Set<Marker> ewtcMarker() {
    return <Marker>[
      Marker(
        position: centerMap,
        markerId: MarkerId('idEWTC'),
      ),
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[900],
        title: Text('Map'),
      ),
      body: myMap(),
    );
  }
}

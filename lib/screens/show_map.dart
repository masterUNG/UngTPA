import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';

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

  @override
  void initState() { 
    super.initState();
    // findLocation();
  }

  // Future<void> findLocation()async{

  //   var location = Location();

  //   Map<String, dynamic> userLocation;

  //   userLocation = (await location.getLocation()) as Map<String, dynamic>;

  //   double latDou = userLocation['latitude'];

  //   print('latDou = $latDou');

  // }

  Widget myMap() {
    return GoogleMap(
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
        title: Text('Map'),
      ),
      body: myMap(),
    );
  }
}

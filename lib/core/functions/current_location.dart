import 'dart:developer';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


Future<Position?> getUserCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Check if location services are enabled
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    print('Location services are disabled.');
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      print('Location permissions are denied');
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    print(
        'Location permissions are permanently denied. Cannot request permissions.');
    return null;
  }

  return await Geolocator.getCurrentPosition();
}

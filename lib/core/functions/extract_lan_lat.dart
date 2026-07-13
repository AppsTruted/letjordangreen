// import 'package:geolocator/geolocator.dart';
//
// Map<String, double>? extractCoordinates(String url) {
//   Uri uri = Uri.parse(url);
//
//   String? query = uri.queryParameters['query'];
//
//   if (query != null && query.isNotEmpty) {
//     List<String> coords = query.split(',');
//
//     if (coords.length == 2) {
//       try {
//         // Convert them to double values
//         double lat = double.tryParse(coords[0]) ?? 0.0;
//         double lon = double.tryParse(coords[1]) ?? 0.0;
//
//         return {
//           'latitude': lat,
//           'longitude': lon,
//         };
//       } catch (e) {
//         print('Error parsing coordinates: $e');
//         return null;
//       }
//     } else {
//       print('Invalid coordinates format');
//       return null;
//     }
//   } else {
//     print('No coordinates found in the URL');
//     return null;
//   }
// }
//
// double calculateDistance(double lat1, double lon1 ) {
//
//   double distanceInMeters = Geolocator.distanceBetween(lat1, lon1, 31.899339213888037, 35.85750814789825);
//
//   double distanceInKilometers = distanceInMeters / 1000;
//   // Print the distance in meters
//   print("Distance:  $distanceInMeters meters  ${distanceInKilometers.ceil()}");
//   return
//     distanceInKilometers;
// }
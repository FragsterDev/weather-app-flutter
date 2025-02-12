import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<bool> requestLocationPermission() async {

    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if(!serviceEnabled){
      return Future.error('Location services are disabled. Please enable it in settings.');
    }

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied){
        return Future.error('Location permission denied. Please allow location permission.');
      }
    }

    if(permission == LocationPermission.deniedForever){
      return Future.error('Location permisison is denied permanently. Please enable it in settings.');
    }

    return true;
  }

  Future<Position?> getCurrentLocation() async {
    try {
      //request permisison before fetching the location
      bool permissionGranted = await requestLocationPermission();

      if(permissionGranted) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        return position;
      } else {
        return null;
      }
    } catch(e) {
      print('Error in getting location: $e');
      return null;
    }
  }

}
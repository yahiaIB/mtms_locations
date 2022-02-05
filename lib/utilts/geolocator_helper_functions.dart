import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projects/app/constants.dart';

class GeoLocatorHelperFunctions {

  static Future<LatLng> getCurrentLocation() async {
    Position position = Constants.position;
    try{
      LocationPermission permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.whileInUse ||  permission == LocationPermission.always){
        position = await Geolocator.getCurrentPosition();
      }
    }catch(e){}
    return _convertPositionToLatLng(position);
  }

  static _convertPositionToLatLng(Position position){
    return LatLng(position.latitude,position.longitude);
  }

}
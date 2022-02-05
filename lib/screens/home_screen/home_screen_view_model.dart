import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projects/app/app_keys.dart';
import 'package:projects/models/source_entity.dart';
import 'package:projects/utilts/dialogs.dart';
import 'package:projects/utilts/geolocator_helper_functions.dart';
import 'package:projects/utilts/helper_functions.dart';
import 'package:projects/viewModels/base_view_model.dart';

class HomeScreenViewModel extends BaseViewModel {
  GoogleMapController? controller;
  LatLng? initPosition;

  init() async {
    _getLocaleLocation();
  }

  SourceEntity? myLocationChoice;
  SourceEntity? destinationChoice;

  _getLocaleLocation() async {
    setBusyWithOutNotify(true);
    initPosition = await GeoLocatorHelperFunctions.getCurrentLocation();
    setBusy(false);
  }

  void onMapCreated(GoogleMapController controller) {
    this.controller = controller;
  }

  setMyLocation(SourceEntity source) {
    myLocationChoice = source;
    notifyListeners();
  }

  setDestination(SourceEntity source) {
    destinationChoice = source;
    notifyListeners();
  }

  requestRD() {
    if (myLocationChoice == null) {
      HelperFunctions.toast(text: "Please select start location");
    } else if (destinationChoice == null) {
      HelperFunctions.toast(text: "Please select destination location");
    } else {
      double distance = calculateDistanceBetweenToLocations(
          myLocationChoice!, destinationChoice!);
      showRDDialog(distance);
    }
  }

  showRDDialog(double distance) {
    Dialogs.showDialogWithTitleAndContent(
        AppKeys.appKeyNavigator.currentContext!,
        "RD",
        SizedBox(
          height: 100,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Distance between source & destination is :"),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${distance < 999 ? distance.toStringAsFixed(2) : (distance / 1000).toStringAsFixed(2)} ${distance < 999 ? "m" : "KM"}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ));
  }

  double calculateDistanceBetweenToLocations(
      SourceEntity source, SourceEntity destination) {
    return Geolocator.distanceBetween(source.latitude!, source.longitude!,
        destination.latitude!, destination.longitude!);
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:projects/app/routes.dart';
import 'package:projects/styles/custom_colors.dart';
import 'package:provider/provider.dart';

import 'home_screen_view_model.dart';
import 'widgets/drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: Stack(
        children: [
          Expanded(
            child: Consumer<HomeScreenViewModel>(
                builder: (context, _model, child) {
              return _model.busy
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      onMapCreated: _model.onMapCreated,
                      initialCameraPosition: CameraPosition(
                        target: _model.initPosition!,
                        zoom: 11.0,
                      ),
                      // onLongPress: _setMarker,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      gestureRecognizers: <
                          Factory<OneSequenceGestureRecognizer>>{
                        Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer(),
                        ),
                      },
                      // markers: Set<Marker>.of(markers.values),
                    );
            }),
          ),
          Positioned(
              bottom: 30,
              right: 0,
              left: 0,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: context.read<HomeScreenViewModel>().requestRD,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .65,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 2,
                              color: Colors.black12)
                        ]),
                    child: const Center(
                      child: Text(
                        "REQUEST RD",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * .1,
            right: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: CustomColors.textGrayColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: 2, blurRadius: 2, color: Colors.black12)
                ],
              ),
              margin: const EdgeInsets.all(10),
              child: Consumer<HomeScreenViewModel>(
                  builder: (context, _model, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: IconButton(
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      _buildLocationItem(text: _model.myLocationChoice != null ? _model.myLocationChoice!.name! : "Your Location", onTap: () {
                        Navigator.pushNamed(context, Routes.sourceLocation);
                      }),
                      _buildLocationItem(text: _model.destinationChoice != null ? _model.destinationChoice!.name! : "Destination", onTap: () {
                        Navigator.pushNamed(context, Routes.destinationLocation);
                      }),
                    ],
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildLocationItem({
    required String text,
    required Function onTap,
  }) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

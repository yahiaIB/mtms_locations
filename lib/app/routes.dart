import 'package:flutter/material.dart';
import 'package:projects/screens/destination_locations/destination_locations_screen.dart';
import 'package:projects/screens/home_screen/home_screen.dart';
import 'package:projects/screens/source_locations/source_locations_screen.dart';


class Routes {
  //TODO Define your routes name, init this routes in material App variable 'routes'
  Routes._();

  //static variables
  static const String initRoute = '/';
  static const String sourceLocation = '/source_locations';
  static const String destinationLocation = '/destination_location';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case initRoute:
        return MaterialPageRoute(builder: (_) =>  HomeScreen(),settings: RouteSettings(name: initRoute));
      case sourceLocation:
        return MaterialPageRoute(builder: (_) =>  SourceLocationsScreen());
      case destinationLocation:
        return MaterialPageRoute(builder: (_) =>  DestinationLocationsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            )
        );
    }
  }

  static final routes = <String, WidgetBuilder>{
    initRoute: (BuildContext context) => HomeScreen(),
  };
}

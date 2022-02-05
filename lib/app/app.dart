import 'package:flutter/material.dart';
import 'package:projects/app/providers.dart';
import 'package:projects/app/routes.dart';
import 'package:projects/styles/custom_theme.dart';
import 'package:provider/provider.dart';

import 'app_keys.dart';
import 'constants.dart';

class RootApp extends StatelessWidget {
  const RootApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
        providers: providers,
        child: MyApp()
      );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      navigatorKey: AppKeys.appKeyNavigator,
      key: AppKeys.appKey,
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.lightTheme,
      title: Constants.appTitle,
      initialRoute: Routes.initRoute,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

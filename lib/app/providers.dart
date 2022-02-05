import 'package:flutter/material.dart';
import 'package:projects/screens/home_screen/home_screen_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  // BlocProvider<Bloc>(
  //   create: (BuildContext context) => Bloc()..add(Event()),
  // ),

  ChangeNotifierProvider<HomeScreenViewModel>(
    create: (BuildContext context) => HomeScreenViewModel()..init()
  ),
];
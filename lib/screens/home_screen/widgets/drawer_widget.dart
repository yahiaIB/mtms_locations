import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Center(child: Text("MTMS",style:TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.blueAccent),))),
          _buildDrawerListTile("Home",Icons.home),
          _buildDrawerListTile("Locations",Icons.location_on),
          _buildDrawerListTile("Source",Icons.location_city_outlined),
          _buildDrawerListTile("Destinations",Icons.location_city),
          _buildDrawerListTile("Settings",Icons.settings),
          _buildDrawerListTile("Privacy Policy",Icons.privacy_tip_outlined),
        ],
      ),
    );
  }

  _buildDrawerListTile(String text,IconData icon){
    return ListTile(title: Row(children: [
      Icon(icon),
      SizedBox(width: 10,),
      Text(text)
    ],),onTap: (){},);
  }
}

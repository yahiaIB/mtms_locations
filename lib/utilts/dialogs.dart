import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class Dialogs {

  static showDialogWithTitleAndContent(BuildContext context, title,Widget content){
    return showDialog<bool>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return Container(
            child: AlertDialog(
              title:   Center(child: Text(title,style: const TextStyle(fontWeight: FontWeight.bold),)),
              content: content,
            ),
          );
        });
  }
}

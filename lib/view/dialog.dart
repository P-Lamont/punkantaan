import 'package:flutter/material.dart';
Future<dynamic> showAlertDialog(BuildContext context, String content,String title) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title:Text(title),
        contentPadding: const EdgeInsets.all(20),
        content: SingleChildScrollView(child:Text(content),)
    )
  );
}
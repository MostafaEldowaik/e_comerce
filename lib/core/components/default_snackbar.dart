import 'package:flutter/material.dart';



showDefaultSnackBar(BuildContext context, String contentString,
    {Color? color , double ? fontSize}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.horizontal,
      elevation: 0.0,
      content: Container(
        decoration: BoxDecoration(
            color: color ?? Colors.redAccent.shade700),
        height: 60,
        padding: const EdgeInsets.all(4.0),
        child: Center(
          child: Text( contentString,)
        ),
      ),
      backgroundColor: Colors.transparent,
    ),
  );
}
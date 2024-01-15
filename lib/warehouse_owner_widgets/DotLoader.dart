import 'package:flutter/material.dart';

class DotLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      width: 8.0,
      height: 8.0,
      decoration: BoxDecoration(
        color: Colors.blue,  // Customize the color as needed
        shape: BoxShape.circle,
      ),
    );
  }
}

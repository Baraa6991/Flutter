// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class IconNavBar extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData iconData;
  final bool activeButton;
  const IconNavBar({
    super.key,
    this.onPressed,
    required this.text,
    required this.iconData,
    required this.activeButton,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: activeButton == true ? Colors.black : Colors.white,
          ),
          Text(
            text,
            style: TextStyle(
              color: activeButton == true ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

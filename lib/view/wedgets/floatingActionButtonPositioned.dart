// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class FloatingActionButtonPositioned extends StatelessWidget {
  const FloatingActionButtonPositioned({
    super.key,
    required this.bottom,
    required this.right,
    required this.color,
    required this.onPressed,
    required this.iconData,
  });
  final double bottom;
  final double right;
  final Color color;
  final void Function()? onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottom,
      right: right,
      child: FloatingActionButton(
        backgroundColor: color,
        onPressed: onPressed,
        child: Icon(iconData),
      ),
    );
  }
}

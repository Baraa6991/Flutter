// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class OfferList extends StatelessWidget {
  const OfferList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        alignment: Alignment.center,
        child: ListTile(
          title: Text(
            "A summer surprise",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          subtitle: Text(
            "Cashback 20%",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        height: 150,
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

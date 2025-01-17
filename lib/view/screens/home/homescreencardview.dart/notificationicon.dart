import 'package:flutter/material.dart';

class NotificationIcon extends StatelessWidget {
  const NotificationIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),  
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.notifications_active_outlined,
          size: 30,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}

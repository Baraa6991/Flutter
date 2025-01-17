// ignore_for_file: prefer_const_constructors, file_names, deprecated_member_use

import 'package:flutter/material.dart';

class OldFatorasBody extends StatelessWidget {
  final int orderId;
  final String totalPrice;
  final List<Map<String, dynamic>> cartItems;

  const OldFatorasBody({
    super.key,
    required this.orderId,
    required this.totalPrice,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orange,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.orange,
              child: Text(
                'Order ID: $orderId',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
              ),
            ),
            SizedBox(
              height: 200, // حدد ارتفاعًا مناسبًا هنا
              child: ListView.separated(
                itemCount: cartItems.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(item['product_name'],
                            style: TextStyle(fontSize: 16)),
                        Text('x${item['quantity']}',
                            style: TextStyle(fontSize: 16)),
                        Text('${item['price']} \$',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    '$totalPrice \$',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

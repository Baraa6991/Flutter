import 'package:flutter/material.dart';

import '../../../core/constant/image.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageAssets.logo,width: 150,height: 150,);
  }
}
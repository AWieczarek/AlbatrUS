import 'dart:ffi';

import 'package:flutter/material.dart';


class RightColumn extends StatelessWidget {

  // final Bool isBird;
  //
  // const RightColumn({super.key, required this.isBird});


  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.baby_changing_station),
        Icon(Icons.arrow_right),
      ],
    );
  }
}
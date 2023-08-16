import 'package:flutter/material.dart';

import 'custom_colors.dart';

class RoundedElevatedButton extends StatelessWidget {
  const RoundedElevatedButton({Key? key, required this.onPress, required this.title}) : super(key: key);
  final Function() onPress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0), // Zaokrąglenie narożników
            ),
          ),
          backgroundColor:
          MaterialStateProperty.all<Color>(CustomColors().myGrayColor)),
      onPressed: onPress,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(title, style: TextStyle(fontSize: 18),),
          ],
        ),
      ),
    );
  }
}

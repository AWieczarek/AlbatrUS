import 'package:flutter/material.dart';

class RightColumn extends StatefulWidget {
  @override
  State<RightColumn> createState() => _RightColumnState();
}

class _RightColumnState extends State<RightColumn> {
  bool isBird = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //Icon(Icons.accessible),
        IconButton(
          iconSize: 34.0,
          icon: Icon(
              isBird ? Icons.accessible : Icons.accessible_forward),
          color: Colors.black,
          onPressed: () {
            setState(() {
              isBird = !isBird;
            });
          },
        ),
        const Icon(Icons.keyboard_arrow_down),
      ],
    );
  }
}

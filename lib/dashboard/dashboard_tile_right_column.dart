import 'package:albatrus/api_routes.dart';
import 'package:albatrus/custom_colors.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';

class RightColumn extends StatefulWidget {
  RightColumn({super.key, required this.trip});

  final Trip trip;

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
          icon: Icon(isBird ? Icons.accessible : Icons.accessible_forward),
          color: CustomColors().secondaryTextColor,
          onPressed: () {
            setState(() {
              isBird = !isBird;
            });
          },
        ),
        IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: CustomColors().secondaryTextColor,
          ),
          onPressed: () {
            Navigator.of(context)
                .pushNamed(AppRoutes.postDetails, arguments: widget.trip);
          },
        ),
      ],
    );
  }
}

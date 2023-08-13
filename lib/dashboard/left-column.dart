import 'package:flutter/material.dart';

import 'date-format.dart';

class LeftColumn extends StatelessWidget {
  final String name;
  final String country;

  const LeftColumn({
    super.key,
    required this.name,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.person,
              size: 34.0),
            const SizedBox(
              height: 5.0,
              width: 10.0,
            ),
            Text(
              name,
              style: const TextStyle(fontSize: 21),
            ),
          ],
        ),
        Row(
          children: [
            DateWidget(date: DateTime.now()),
            const SizedBox(
              height: 5.0,
              width: 5.0,
            ),
            Text(
              'visited ${country}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ],
    );
  }
}

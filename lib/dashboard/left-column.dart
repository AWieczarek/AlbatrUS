import 'package:albatrus/dashboard/dashboard-item.dart';
import 'package:flutter/material.dart';

class LeftColumn extends StatelessWidget {
  final String name;
  final String country;
  final String date;

  const LeftColumn({
    super.key,
    required this.name,
    required this.country,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.person),
            Text( name,
              style: const TextStyle(fontSize: 21),
            ),
          ],
        ),
        Text(
          '${date} visited ${country}',
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

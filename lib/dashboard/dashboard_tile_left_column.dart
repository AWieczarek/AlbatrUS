import 'package:flutter/material.dart';

import 'date_format.dart';

class LeftColumn extends StatelessWidget {
  final String name;
  final DateTime dateFrom;
  final String city;
  final String country;

  const LeftColumn({
    super.key,
    required this.name,
    required this.dateFrom,
    required this.city,
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
            const Icon(Icons.person, size: 34.0),
            const SizedBox(
              height: 5.0,
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 21),
                  textAlign: TextAlign.left,
                ),
                DateWidget(date: dateFrom),
              ],
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.5,
              child: Text(
                'visited ${city}, ${country}',
                style: const TextStyle(fontSize: 18),
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

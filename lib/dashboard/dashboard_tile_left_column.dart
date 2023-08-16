import 'package:albatrus/custom_colors.dart';
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
            Icon(Icons.person, size: 34.0, color: CustomColors().secondaryTextColor,),
            const SizedBox(
              height: 5.0,
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, color: CustomColors().textColor),
                  textAlign: TextAlign.left,
                ),
                DateWidget(date: dateFrom, textColor: CustomColors().secondaryTextColor, fontSize: 12.0),
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
                style: TextStyle(fontSize: 16, color: CustomColors().textColor),
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

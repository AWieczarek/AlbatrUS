import 'package:albatrus/custom_colors.dart';
import 'package:albatrus/dashboard/date_format.dart';
import 'package:albatrus/trip-details/details_date_field.dart';
import 'package:albatrus/trip-details/details_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/trip.dart';

class Details extends StatelessWidget {
  final Trip trip;
  Color color2 = Color.fromRGBO(255, 4, 18, 0.13);

  Details({
    super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Trip Details'),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 21),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DetailsTextField(coto: 'Country', detail: trip.country),
            DetailsTextField(coto: 'City', detail: trip.city),
            DetailsTextField(coto: 'Description', detail: trip.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailsDateField(fromto: 'From', date: trip.dateFrom),
                DetailsDateField(fromto: 'To', date: trip.dateTo),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 5.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(35)),
                    color: CustomColors().myGrayColor,
                    border: Border.all(
                      //color: CustomColors().strokeColor,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15.0),
                      child: Text(
                          style: const TextStyle(
                              fontSize: 24, color: Colors.white),
                          '${trip.rate}'))),
            ),
          ],
        ),
      ),
    );
  }
}

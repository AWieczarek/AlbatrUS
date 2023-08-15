import 'package:albatrus/custom_colors.dart';
import 'package:flutter/material.dart';

import '../dashboard/date_format.dart';

class DetailsDateField extends StatelessWidget {
  final DateTime date;
  final String fromto;

  DetailsDateField({
    super.key,
    required this.date,
    required this.fromto,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0.0),
      child: Flexible(
        child: Expanded(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0.0),
                child: Text(
                  fromto,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 12,
                    color: CustomColors().strokeColor,
                  ),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    color: CustomColors().myGrayColor,
                    border: Border.all(
                      //color: CustomColors().strokeColor,
                    ),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: DateWidget(date: date, textColor: CustomColors().textColor, fontSize: 14,))),
            ],
          ),
        ),
      ),
    );
  }
}

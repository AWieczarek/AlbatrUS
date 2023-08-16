import 'package:albatrus/custom_colors.dart';
import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  DateRangePickerWidget(
      {super.key,
      required this.dateFromChanged,
      required this.dateToChanged,
      required this.dateFrom,
      required this.dateTo});

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();

  final ValueChanged<DateTime> dateFromChanged;
  final ValueChanged<DateTime> dateToChanged;
  DateTime dateFrom;
  DateTime dateTo;
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  // DateTime _startDate = DateTime.now();
  // DateTime _endDate = DateTime.now();

  final double labelSize = 12;

  final bgColor = CustomColors().backgroundColor;
  final textColor = CustomColors().secondaryTextColor;
  final formBgColor = Colors.grey[700];
  final formTextColor = CustomColors().secondaryTextColor;
  final formBorderColor = CustomColors().strokeColor;
  final formFocusColor = CustomColors().strokeColor;
  final buttonBgColor = CustomColors().myGrayColor;
  final buttonTextColor = CustomColors().textColor;
  final warningColor = CustomColors().myRedColor;
  final warningTextColor = CustomColors().textColor;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? widget.dateFrom : widget.dateTo,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null &&
        picked != (isStartDate ? widget.dateFrom : widget.dateTo)) {
      setState(() {
        if (isStartDate) {
          widget.dateFrom = picked;
          widget.dateFromChanged(picked);
        } else {
          widget.dateTo = picked;
          widget.dateToChanged(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Text("From",
                style: TextStyle(
                  color: textColor,
                  fontSize: labelSize,
                )),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: formBorderColor,
                ),
                // Kolor i styl granicy
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent, // Kolor tła przycisku
                ),
                onPressed: () => _selectDate(context, true),
                child: Text(
                  "${widget.dateFrom.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text("To",
                style: TextStyle(
                  color: textColor,
                  fontSize: labelSize,
                )),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: formBorderColor,
                ),
                // Kolor i styl granicy
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.transparent, // Kolor tła przycisku
                ),
                onPressed: () => _selectDate(context, false),
                child: Text(
                  "${widget.dateTo.toLocal()}".split(' ')[0],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

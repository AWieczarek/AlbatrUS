import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  DateRangePickerWidget(
      {super.key, required this.dateFromChanged, required this.dateToChanged, required this.dateFrom, required this.dateTo});

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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? widget.dateFrom : widget.dateTo,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != (isStartDate ? widget.dateFrom : widget.dateTo)) {
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
            const Text("From"),
            ElevatedButton(
              onPressed: () => _selectDate(context, true),
              child: Text("${widget.dateFrom.toLocal()}".split(' ')[0]),
            ),
          ],
        ),
        Column(
          children: [
            const Text("To"),
            ElevatedButton(
              onPressed: () => _selectDate(context, false),
              child: Text("${widget.dateTo.toLocal()}".split(' ')[0]),
            ),
          ],
        ),
      ],
    );
  }
}

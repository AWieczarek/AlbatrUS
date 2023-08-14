import 'package:flutter/material.dart';

class DateRangePickerWidget extends StatefulWidget {
  const DateRangePickerWidget(
      {super.key, required this.dateFromChanged, required this.dateToChanged, required this.dateFrom, required this.dateTo});

  @override
  _DateRangePickerWidgetState createState() => _DateRangePickerWidgetState();

  final ValueChanged<DateTime> dateFromChanged;
  final ValueChanged<DateTime> dateToChanged;
  final DateTime dateFrom;
  final DateTime dateTo;
}

class _DateRangePickerWidgetState extends State<DateRangePickerWidget> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != (isStartDate ? _startDate : _endDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          widget.dateFromChanged(picked);
        } else {
          _endDate = picked;
          widget.dateToChanged(picked);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _startDate = widget.dateFrom;
    _endDate = widget.dateTo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            const Text("From"),
            ElevatedButton(
              onPressed: () => _selectDate(context, true),
              child: Text("${_startDate.toLocal()}".split(' ')[0]),
            ),
          ],
        ),
        Column(
          children: [
            const Text("To"),
            ElevatedButton(
              onPressed: () => _selectDate(context, false),
              child: Text("${_endDate.toLocal()}".split(' ')[0]),
            ),
          ],
        ),
      ],
    );
  }
}

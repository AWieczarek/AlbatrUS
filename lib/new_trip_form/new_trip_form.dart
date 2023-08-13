import 'package:albatrus/new_trip_form/city_selector.dart';
import 'package:albatrus/new_trip_form/country_selector.dart';
import 'package:albatrus/new_trip_form/date_range_picker.dart';
import 'package:albatrus/new_trip_form/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class NewTripForm extends StatefulWidget {
  const NewTripForm({super.key});

  @override
  _NewTripFormState createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();
  countries.Country? _country;
  String _countryISO = "PL";
  countries.City? _city;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _rating;
  String _result = "Result";

  void _countrySelected(countries.Country selectedItem) {
    setState(() {
      _country = selectedItem;
      _countryISO = selectedItem.isoCode;
    });
  }

  void _citySelected(countries.City selectedItem) {
    _city = selectedItem;
  }

  void _ratingSelected(int selectedItem) {
    _rating = selectedItem;
  }

  void _dateFromSelected(DateTime selectedItem) {
    _startDate = selectedItem;
  }

  void _dateToSelected(DateTime selectedItem) {
    _endDate = selectedItem;
  }

  void _updateResults() {
    setState(() {
      _result =
          "${_country!.name} ${_city!.name} ${_description} ${_startDate} ${_endDate} ${_rating}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Trip'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CountrSelector(
              countrySelected: _countrySelected,
            ),
            CitySelector(
              countryISO: _countryISO,
              citySelected: _citySelected,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                minLines: 3,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  // filled: true, //<-- SEE HERE
                  // fillColor: Colors.grey[150], //<-- SEE HE
                  labelText: "Description",
                  hintText: 'Enter Description...',
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DateRangePickerWidget(
              dateFromChanged: _dateFromSelected,
              dateToChanged: _dateToSelected,
            ),
            const SizedBox(
              height: 32,
            ),
            RatingWidget(
              onSelect: _ratingSelected,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  child: Text(
                    _result,
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                ),
                ElevatedButton(
                  onPressed: _updateResults,
                  child: const Row(
                    children: [
                      Text("Save "),
                      Icon(
                        Icons.save,
                        size: 30,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

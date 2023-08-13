import 'package:albatrus/api_routes.dart';
import 'package:albatrus/database_service.dart';
import 'package:albatrus/new_trip_form/city_selector.dart';
import 'package:albatrus/new_trip_form/country_selector.dart';
import 'package:albatrus/new_trip_form/date_range_picker.dart';
import 'package:albatrus/new_trip_form/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;
import 'package:flutter/services.dart';

import '../models/trip.dart';

class NewTripForm extends StatefulWidget {
  const NewTripForm({super.key});

  @override
  _NewTripFormState createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _descriptionController = TextEditingController();
  countries.Country? _country;
  String _countryISO = "PL";
  countries.City? _city;
  String _description= "";
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  int _rating = 3;
  bool _showBanner = false;
  String _errorMessage = "";

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

  void _saveTrip() {
    _errorMessage = _validateForm();
    if (_errorMessage == "") {
      setState(() {
        _showBanner = false;
        DatabaseService.createTrip(Trip(
          country: _country!.name,
          city: _city!.name,
          dateFrom: _startDate,
          dateTo: _endDate,
          description: _description,
          rate: _rating,
        ));
        Navigator.of(context).pushNamed(AppRoutes.home);
      });
      print("ready to send");
    } else {
      setState(() {
        _showBanner = true;
      });
    }
  }

  String _validateForm() {
    String x = "";
    if (_country == null) x += "Please select country\n";
    if (_city == null) x += "Please select city\n";
    if (_description.length < 5)
      x += "Description should be at least 5 characters\n";

    return x;
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('New Trip'),
      ),
      body: Column(
        children: [
          if (_showBanner)
            Container(
              color: Colors.red[300],
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning, color: Colors.white),
                  const SizedBox(width: 8.0),
                  Text(
                    _errorMessage,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          CountrySelector(
            countrySelected: _countrySelected,
          ),
          CitySelector(
            countryISO: _countryISO,
            citySelected: _citySelected,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _descriptionController,
              onChanged: (value) {
                setState(() {
                  _description = value;
                });
              },
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
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
              ElevatedButton(
                onPressed: _saveTrip,
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
    );
  }
}

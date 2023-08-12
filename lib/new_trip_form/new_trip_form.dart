import 'package:albatrus/new_trip_form/city_selector.dart';
import 'package:albatrus/new_trip_form/country_selector.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class NewTripForm extends StatefulWidget {
  const NewTripForm({super.key});

  @override
  _NewTripFormState createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();
  String _countryISO = 'PL';
  String? _city;
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _rating;

  void _onItemSelected(String selectedItem) {
    setState(() {
      _countryISO = selectedItem;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CountrSelector(
                countrySelected: _onItemSelected,
              ) ,
              const SizedBox(height: 10),
              Container(
                height: 100,
                child: CitySelector(
                  countryISO: _countryISO,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

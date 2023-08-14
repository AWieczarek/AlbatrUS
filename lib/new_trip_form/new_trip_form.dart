import 'package:albatrus/api_routes.dart';
import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/user_short.dart';
import 'package:albatrus/new_trip_form/city_selector.dart';
import 'package:albatrus/new_trip_form/country_selector.dart';
import 'package:albatrus/new_trip_form/date_range_picker.dart';
import 'package:albatrus/new_trip_form/rating_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;
import 'package:flutter/services.dart';

import '../models/trip.dart';

class NewTripForm extends StatefulWidget {
  NewTripForm({super.key, required this.tripData});

  Trip tripData = Trip(
      country: "",
      city: "",
      dateFrom: DateTime.now(),
      dateTo: DateTime.now(),
      description: "",
      rate: 0,
      user: UserShort(userId: "", username: ""));

  @override
  _NewTripFormState createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();

  String _country = "";
  String _countryISO = "PL";
  String _city = "";
  String _description = "";
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  int _rating = 3;

  bool _showBanner = false;
  String _errorMessage = "";
  User? user = FirebaseAuth.instance.currentUser;

  late Future<List<countries.Country>> countriesFuture;
  late Future<List<countries.City>> citiesFuture;

  void _countrySelected(countries.Country selectedItem) {
    setState(() {
      _country = selectedItem.name;
      _countryISO = selectedItem.isoCode;
    });
  }

  void _citySelected(countries.City selectedItem) {
    _city = selectedItem.name;
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
      _showBanner = false;
      DatabaseService.insertTripWithUserReference(Trip(
        country: _country!,
        city: _city!,
        dateFrom: _startDate,
        dateTo: _endDate,
        description: _description,
        rate: _rating,
        user: UserShort(userId: "user!.uid", username: "user!.displayName!"),
      ));
      Navigator.of(context).pushNamed(AppRoutes.home);
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

  late TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    _country = widget.tripData.country;
    _city = widget.tripData.city;
    _description = widget.tripData.description;
    _startDate = widget.tripData.dateFrom;
    _endDate = widget.tripData.dateTo;
    _rating = widget.tripData.rate;
    _descriptionController = TextEditingController(text: _description);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('New Trip'),
      ),
      body: FutureBuilder(
          future: Future.wait([
            countries.getAllCountries(),
            countries.getCountryCities(_countryISO)
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Text('Country Selector Error');
            } else if (snapshot.hasData) {
              List<countries.Country> countriesList = snapshot.data![0];
              List<countries.City> citiesList = snapshot.data![1];
              return Column(
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
                    onCountrySelected: _countrySelected,
                    countriesList: countriesList,
                    selectedCountry: countries.Country(
                        name: _country,
                        isoCode: _countryISO,
                        phoneCode: "",
                        flag: "",
                        currency: "",
                        latitude: "",
                        longitude: ""),
                  ),
                  CitySelector(
                    selectedCity: _city,
                    countryISO: _countryISO,
                    onCitySelected: _citySelected,
                    cityList: citiesList,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _descriptionController,
                      onChanged: (value) {
                        _description = value;
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
                    dateFrom: _startDate,
                    dateTo: _endDate,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  RatingWidget(
                    onSelect: _ratingSelected,
                    initialValue: _rating,
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
              );
            } else {
              return const Text("Inconsistant");
            }
          }),
    );
  }
}

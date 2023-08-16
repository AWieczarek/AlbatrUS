import 'package:albatrus/api_routes.dart';
import 'package:albatrus/custom_colors.dart';
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
import '../rounded_elevated_button.dart';

class NewTripForm extends StatefulWidget {
  NewTripForm({super.key, required this.tripData});

  Trip tripData;

  @override
  _NewTripFormState createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();

  final bgColor = CustomColors().backgroundColor;
  final textColor = CustomColors().textColor;
  final formBgColor = CustomColors().myGrayColor;
  final formTextColor = CustomColors().secondaryTextColor;
  final formBorderColor = CustomColors().strokeColor;
  final formFocusColor = CustomColors().strokeColor;
  final buttonBgColor = CustomColors().myGrayColor;
  final buttonTextColor = CustomColors().textColor;
  final warningColor = CustomColors().myRedColor;
  final warningTextColor = CustomColors().textColor;

  String _countryISO = "";

  bool _showBanner = false;
  String _errorMessage = "";
  User? user = FirebaseAuth.instance.currentUser;

  late Future<List<countries.Country>> countriesFuture;
  late Future<List<countries.City>> citiesFuture;

  void _countrySelected(countries.Country selectedItem) {
    setState(() {
      widget.tripData.country = selectedItem.name;
      _countryISO = selectedItem.isoCode;
    });
  }

  void _citySelected(countries.City selectedItem) {
    widget.tripData.city = selectedItem.name;
  }

  void _ratingSelected(int selectedItem) {
    widget.tripData.rate = selectedItem;
  }

  void _dateFromSelected(DateTime selectedItem) {
    widget.tripData.dateFrom = selectedItem;
  }

  void _dateToSelected(DateTime selectedItem) {
    widget.tripData.dateTo = selectedItem;
  }

  void _saveTrip() {
    _errorMessage = _validateForm();
    if (_errorMessage == "") {
      _showBanner = false;
      DatabaseService.insertTripWithUserReference(Trip(
        country: widget.tripData.country,
        city: widget.tripData.city,
        dateFrom: widget.tripData.dateFrom,
        dateTo: widget.tripData.dateTo,
        description: widget.tripData.description,
        rate: widget.tripData.rate,
        user: UserShort(userId: user!.uid, username: user!.displayName!),
      ));
      Navigator.of(context).pop();
    } else {
      setState(() {
        _showBanner = true;
      });
    }
  }

  String _validateForm() {
    String x = "";
    if (widget.tripData.country == null) x += "Please select country\n";
    if (widget.tripData.city == null) x += "Please select city\n";
    if (widget.tripData.description.length < 5)
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
    _descriptionController =
        TextEditingController(text: widget.tripData.description);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    print("selectedCountry: ${widget.tripData.country} duuuuuuuuuuuupa");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('New Trip'),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 21),
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
                      color: warningColor,
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.warning, color: warningTextColor),
                          const SizedBox(width: 8.0),
                          Text(
                            _errorMessage,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: warningTextColor),
                          ),
                        ],
                      ),
                    ),
                  CountrySelector(
                    selectedCountry: widget.tripData.country,
                    onCountrySelected: _countrySelected,
                    countriesList: countriesList,
                  ),
                  CitySelector(
                    selectedCity: widget.tripData.city,
                    countryISO: _countryISO,
                    onCitySelected: _citySelected,
                    cityList: citiesList,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      style: TextStyle(color: CustomColors().textColor, fontSize: 18),
                      controller: _descriptionController,
                      onChanged: (value) {
                        widget.tripData.description = value;
                      },
                      minLines: 3,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      cursorColor: formTextColor,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: formBorderColor),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        filled: true,
                        fillColor: formBgColor,
                        focusColor: formFocusColor,
                        labelText: "Description",
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: formBorderColor),
                        ),
                        labelStyle: TextStyle(color: formTextColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  DateRangePickerWidget(
                    dateFromChanged: _dateFromSelected,
                    dateToChanged: _dateToSelected,
                    dateFrom: widget.tripData.dateFrom,
                    dateTo: widget.tripData.dateTo,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  RatingWidget(
                    onSelect: _ratingSelected,
                    initialValue: widget.tripData.rate,
                    changable: true,
                    size: 40,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RoundedElevatedButton(onPress: _saveTrip, title:  "save",)
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

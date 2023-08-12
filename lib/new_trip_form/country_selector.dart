import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class CountrSelector extends StatefulWidget {
  CountrSelector({super.key});

  // final Function onTouched;

  @override
  State<CountrSelector> createState() => _CountrSelectorState();
}

class _CountrSelectorState extends State<CountrSelector> {
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: countries.getAllCountries(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SafeArea(
                  top: false,
                  child: Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return SafeArea(
                  top: false,
                  child: Scaffold(
                    body: Center(
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ),
                );
              } else if (snapshot.hasData) {
                return DropdownSearch<String>(
                  enabled: true,
                  items:
                      snapshot.data!.map((el) => el.name.toString()).toList(),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Country",
                      hintText: "Select country",
                    ),
                  ),
                  filterFn: (String item, String query) {
                    return item.toLowerCase().contains(query.toLowerCase());
                  },
                );
              } else {
                return const Text("Inconsistant");
              }
            }));
  }
}

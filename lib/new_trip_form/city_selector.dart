import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as city;
import 'package:dropdown_search/dropdown_search.dart';

class CitySelector extends StatefulWidget {
  CitySelector({super.key, this.country});

  final city.Country? country;

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  String? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
            future: city.getCountryCities(widget.country!.isoCode),
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
                  enabled: widget.country != null,
                  items:
                      snapshot.data!.map((el) => el.name.toString()).toList(),
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "City",
                      hintText: "Select city",
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

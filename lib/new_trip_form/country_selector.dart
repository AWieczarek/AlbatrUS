import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class CountrSelector extends StatefulWidget {
  CountrSelector({super.key, required this.countrySelected});

  final ValueChanged<String> countrySelected;

  @override
  State<CountrSelector> createState() => _CountrSelectorState();
}

class _CountrSelectorState extends State<CountrSelector> {
  countries.Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<countries.Country>>(
            future: countries.getAllCountries(),
            builder: (context, snapshot) {
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
              return DropdownSearch<countries.Country>(
                  enabled: true,
                  onChanged: (value) {
                    _selectedCountry = value;
                    widget.countrySelected(value!.isoCode);
                  },
                  selectedItem: _selectedCountry,
                  items:
                      snapshot.data!,
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Country",
                      hintText: "Select country",
                    ),
                  ),
                  itemAsString: (countries.Country x){
                    return x.name;
                  },
                  // snapshot.data!.map((el) => el.name.toString()).toList(),
                  filterFn: (countries.Country item, String query) {
                    return item.name.toLowerCase().contains(query.toLowerCase());
                  },
                );
              } else {
                return const Text("Inconsistant");
              }
            }));
  }
}

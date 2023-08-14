import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class CountrySelector extends StatefulWidget {
  CountrySelector(
      {super.key, required this.onCountrySelected, required this.countriesList, required this.selectedCountry});

  final List<countries.Country> countriesList;
  final ValueChanged<countries.Country> onCountrySelected;
  final countries.Country? selectedCountry;

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  @override
  Widget build(BuildContext context) {
    countries.Country? _selectedCountry;
    if (widget.onCountrySelected != null) {
      _selectedCountry = widget.selectedCountry;
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: DropdownSearch<countries.Country>(
        enabled: true,
        onChanged: (value) {
          _selectedCountry = value;
          widget.onCountrySelected(value!);
          print("dupa");
        },
        selectedItem: _selectedCountry,
        items: widget.countriesList,
        itemAsString: (countries.Country x) {
          return x.name;
        },
        compareFn: (i, s) => i == s,
        popupProps: PopupPropsMultiSelection.dialog(
          //TODO dodać wyszarzenie tła
          searchDelay: const Duration(milliseconds: 300),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          showSelectedItems: true,
          // onItemAdded:
          showSearchBox: true,
        ),
        // dropdownBuilder: ,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Country",
            hintText: "Select country",
          ),
        ),
        // snapshot.data!.map((el) => el.name.toString()).toList(),
        filterFn: (countries.Country item, String query) {
          return item.name.toLowerCase().contains(query.toLowerCase());
        },
      ),
    );
  }
}

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class CountrySelector extends StatefulWidget {
  CountrySelector(
      {super.key, required this.onCountrySelected, required this.countriesList, required this.selectedCountry});

  final List<countries.Country> countriesList;
  final ValueChanged<countries.Country> onCountrySelected;
  String selectedCountry;

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {

  countries.Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
      _selectedCountry = countries.Country(
          name: widget.selectedCountry,
          isoCode: "",
          phoneCode: "",
          flag: "",
          currency: "",
          latitude: "",
          longitude: "");
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: DropdownSearch<countries.Country>(
        enabled: true,
        selectedItem: countries.Country(
            name: widget.selectedCountry,
            isoCode: "",
            phoneCode: "",
            flag: "",
            currency: "",
            latitude: "",
            longitude: ""),
        onChanged: (value) {
          widget.selectedCountry = value!.name;
          widget.onCountrySelected(value!);
        },
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
        dropdownDecoratorProps: const DropDownDecoratorProps(
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

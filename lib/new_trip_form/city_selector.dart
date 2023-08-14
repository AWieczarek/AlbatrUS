import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as city;
import 'package:dropdown_search/dropdown_search.dart';

class CitySelector extends StatefulWidget {
  CitySelector(
      {super.key, required this.countryISO, required this.onCitySelected, required this.cityList, required this.selectedCity});

  final ValueChanged<city.City> onCitySelected;
  String selectedCity;
  final List<city.City> cityList;
  final String countryISO;

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  // city.City? _selectedCity;

  @override
  Widget build(BuildContext context) {
    // _selectedCity = city.City(
    //     name: widget.selectedCity, countryCode: "", stateCode: "");
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Flex(direction: Axis.horizontal, children: [
          Expanded(
            child: DropdownSearch<city.City>(
              enabled: true,
              selectedItem: city.City(
                     name: widget.selectedCity, countryCode: "", stateCode: ""),
              compareFn: (i, s) => i == s,
              onChanged: (value) {
                widget.selectedCity = value!.name;
                widget.onCitySelected(value!);
              },
              popupProps: PopupPropsMultiSelection.dialog(
                searchDelay: const Duration(milliseconds: 300),
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                showSelectedItems: true,
                // onItemAdded:
                showSearchBox: true,
              ),
              items: widget.cityList,
              itemAsString: (city.City x) {
                return x.name;
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Colors.grey[100],
                  labelText: "City",
                  hintText: "Select city",
                ),
              ),
              filterFn: (city.City item, String query) {
                return item.name.toLowerCase().contains(query.toLowerCase());
              },
            ),
          ),
        ])
    );
  }
}


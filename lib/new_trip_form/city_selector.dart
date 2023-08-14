import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as city;
import 'package:dropdown_search/dropdown_search.dart';

class CitySelector extends StatefulWidget {
  CitySelector({super.key, required this.countryISO, required this.citySelected});

  final ValueChanged<city.City> citySelected;
  final String countryISO;

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  city.City? _selectedCity;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: FutureBuilder(
            future: city.getCountryCities(widget.countryISO),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('City Selector Error');
              } else if (snapshot.hasData) {
                return Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    child: DropdownSearch<city.City>(
                      enabled: true,
                      selectedItem: _selectedCity,
                      compareFn: (i, s) => i == s,
                      onChanged: (value) {//TODO ten sam lag jest patrz country selector
                        _selectedCity = value;
                        widget.citySelected(value!);
                      },
                      popupProps: PopupPropsMultiSelection.bottomSheet (
                        //TODO dodać wyszarzenie tła
                        //TODO nie odklikuje się xd
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
                      clearButtonProps: const ClearButtonProps(isVisible: true),
                      items: snapshot.data!,
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
                ]);
              } else {
                return const Text("Inconsistent");
              }
            }));
  }
}

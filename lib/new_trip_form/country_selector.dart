import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class CountrySelector extends StatefulWidget {
  CountrySelector({super.key, required this.countrySelected});

  final ValueChanged<countries.Country> countrySelected;

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  countries.Country? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: FutureBuilder<List<countries.Country>>(
            future: countries.getAllCountries(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return const Text('Country Selector Error');
              } else if (snapshot.hasData) {
                return Flex(direction: Axis.horizontal, children: [
                  Expanded(
                    child: DropdownSearch<countries.Country>(
                      enabled: true,
                      onChanged: (value) {
                        _selectedCountry = value;
                        widget.countrySelected(value!);
                        print("dupa");//TODO do refactoru z errorBuilderami i empty builderami, może wyeliminuje to laga
                      },
                      selectedItem: _selectedCountry,
                      items: snapshot.data!,
                      itemAsString: (countries.Country x) {
                        return x.name;
                      },
                      compareFn: (i, s) => i==s,
                      popupProps: PopupPropsMultiSelection.bottomSheet (
                        //TODO dodać wyszarzenie tła
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
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelText: "Country",
                          hintText: "Select country",
                        ),
                      ),
                      // snapshot.data!.map((el) => el.name.toString()).toList(),
                      filterFn: (countries.Country item, String query) {
                        return item.name
                            .toLowerCase()
                            .contains(query.toLowerCase());
                      },
                    ),
                  ),
                ]);
              } else {
                return const Text("Inconsistant");
              }
            }));
  }
}

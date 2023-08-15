import 'package:albatrus/custom_colors.dart';
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

  final bgColor = CustomColors().backgroundColor;
  final popupColor = CustomColors().myGrayColor;
  final textColor = CustomColors().textColor;
  final formBgColor = Colors.grey[700];
  final formTextColor = CustomColors().secondaryTextColor;
  final formBorderColor = CustomColors().strokeColor;
  final formFocusColor = CustomColors().strokeColor;
  final buttonBgColor = CustomColors().myGrayColor;
  final buttonTextColor = CustomColors().textColor;
  final warningColor = CustomColors().myRedColor;
  final warningTextColor = CustomColors().textColor;

  @override
  Widget build(BuildContext context) {
    // _selectedCity = city.City(
    //     name: widget.selectedCity, countryCode: "", stateCode: "");
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
                itemBuilder:
                    (BuildContext context, city.City item, bool isSelected) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: CustomColors().textColor, // Kolor tekstu
                      ),
                    ),
                  );
                },
                searchDelay: const Duration(milliseconds: 300),
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    labelText: "Search",
                    labelStyle: TextStyle(color: CustomColors().secondaryTextColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                dialogProps: DialogProps(
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0), // Zaokrąglenie narożników
                  ),
                  backgroundColor: popupColor,
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
                baseStyle: TextStyle(color: CustomColors().textColor, fontSize:18 ),
                dropdownSearchDecoration: InputDecoration(
                  filled: true,
                  //<-- SEE HERE
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: CustomColors().strokeColor,
                        width: 20,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  focusedBorder: InputBorder.none,
                  fillColor: CustomColors().myGrayColor,
                  labelText: "City",
                  labelStyle: TextStyle(color: CustomColors().secondaryTextColor),
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


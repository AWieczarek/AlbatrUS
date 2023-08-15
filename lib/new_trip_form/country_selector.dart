import 'package:albatrus/custom_colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as countries;

class CountrySelector extends StatefulWidget {
  CountrySelector(
      {super.key,
      required this.onCountrySelected,
      required this.countriesList,
      required this.selectedCountry});

  // final bgColor=Colors.black;
  final bgColor = CustomColors().backgroundColor;
  final popupColor = CustomColors().myGrayColor;
  final textColor = CustomColors().textColor;
  final formBgColor = CustomColors().myGrayColor;
  final formTextColor = CustomColors().secondaryTextColor;
  final formBorderColor = CustomColors().strokeColor;
  final formFocusColor = CustomColors().strokeColor;
  final buttonBgColor = CustomColors().myGrayColor;
  final buttonTextColor = CustomColors().textColor;
  final warningColor = CustomColors().myRedColor;
  final warningTextColor = CustomColors().textColor;

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
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
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
            backgroundColor: widget.popupColor,
          ),
          itemBuilder:
              (BuildContext context, countries.Country item, bool isSelected) {
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
          showSelectedItems: true,
          // onItemAdded:
          showSearchBox: true,
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: TextStyle(color: CustomColors().textColor, fontSize:18 ),
          dropdownSearchDecoration: InputDecoration(
            filled: true,
            //<-- SEE HERE
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  color: widget.formBorderColor,
                  width: 20,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(16.0),
            ),
            focusedBorder: InputBorder.none,
            fillColor: widget.formBgColor,
            labelText: "Country",
            labelStyle: TextStyle(color: widget.formTextColor),
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

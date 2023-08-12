import 'package:flutter/material.dart';
import 'package:country_state_city/country_state_city.dart' as city;
import 'package:dropdown_search/dropdown_search.dart';

class CitySelector extends StatefulWidget {
  CitySelector({super.key, required this.countryISO});

  final String countryISO;



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
            future: city.getCountryCities(widget.countryISO),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Text('dupa'),
                );
              }else if (snapshot.hasError) {
                return SafeArea(
                  top: false,
                  child: Scaffold(
                    body: Center(
                      child: Text('dupa'),
                      ),
                  ),
                );
              } else if (snapshot.hasData) {
                return Expanded(
                  child: DropdownSearch<String>(
                    enabled: true,
                    items: snapshot.data!.map((el) => el.name.toString()).toList(),
                    dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "City",
                        hintText: "Select city",
                      ),
                    ),
                    filterFn: (String item, String query) {
                      return item.toLowerCase().contains(query.toLowerCase());
                    },
                  ),
                );
              }else {
                return const Text("Inconsistant");
              }
              }
        ));
  }
}

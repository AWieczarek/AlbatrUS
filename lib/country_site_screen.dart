import 'package:flutter/material.dart';
//import 'package:country_state_city/country_state_city.dart' as city;
import 'package:albatrus/database_service.dart';

/// This widget is the home page of the application.
class CountrySiteScreen extends StatefulWidget {
  /// Initialize the instance of the [CountrySiteScreen] class.
  const CountrySiteScreen({Key? key}) : super(key: key);

  @override
  State<CountrySiteScreen> createState() => _CountrySiteScreenState();
}

class _CountrySiteScreenState extends State<CountrySiteScreen> {
  _CountrySiteScreenState();

  late bool _snackTime = false;

  late SnackBar _snackBar;
  late String _haveYouBeenToThisCountry;

  final Color myBlue = Color.fromRGBO(60, 90, 200, 1.0);
  final Color myGreen = Color.fromRGBO(60, 200, 30, 1.0);
  final Color myYellow = Color.fromRGBO(200, 200, 30, 1.0);

  @override
  void initState() {
    _haveYouBeenToThisCountry = "byles"; //TO DO (byłeś tu ostatnio / nie byłeś tu)





    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("<nazwa kraju>"), //TO DO
          Text(_haveYouBeenToThisCountry), //TO DO
          Text("Znajomi którzy tu byli:"),
          Row(
            children: [Text("nick1"), Text("nick2")], //TO DO AWATARY
          ),
          Text("Znajomi którzy chcą się tu wybrać:"),
          Row(
            children: [Text("nick1"), Text("nick2")], //TO DO AWATARY
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print("bylem tu <kraj>"); //przejscie do innego scenariusza
                },
                child: Text('bylem tu'),
              ),
              ElevatedButton(
                onPressed: () {
                  print("chce tu bycc"); // chce tu byc - zaznaczenie
                },
                child: Text('chce tu byc'),
              ),
              ElevatedButton(
                onPressed: () {
                  print("go back please :3"); // wroc
                },
                child: Text('Powróć'),
              )
            ], //TO DO AWATARY
          ),
        ],
      ),
    );
  }
}
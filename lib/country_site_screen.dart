import 'package:albatrus/dashboard/asia_sandbox.dart';
import 'package:albatrus/dowolnie.dart';
import 'package:flutter/material.dart';
//import 'package:country_state_city/country_state_city.dart' as city;
import 'package:albatrus/database_service.dart';

import 'models/trip.dart';

/// This widget is the home page of the application.
class CountrySiteScreenDelete extends StatefulWidget {
  /// Initialize the instance of the [CountrySiteScreenDelete] class.
  const CountrySiteScreenDelete({Key? key}) : super(key: key);

  @override
  State<CountrySiteScreenDelete> createState() => _CountrySiteScreenDeleteState();
}

class _CountrySiteScreenDeleteState extends State<CountrySiteScreenDelete> {
  //final Set<String> friends;

  //_CountrySiteScreenState({required this.friends});

  late bool _snackTime = false;

  late SnackBar _snackBar;
  late String _haveYouBeenToThisCountry;

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


class CountrySiteScreen extends StatelessWidget {

  final String countryName;
  final List<Trip> trips;

  CountrySiteScreen({required this.countryName, required this.trips});

  void initState() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(child: Text(countryName)),
          Expanded(
            // child: ListView.builder(
            //   itemCount: friends.length, // Liczba elementów
            //   itemBuilder: (context, index) {
            //     return ListTile(
            //       title: Text(friends[index]),
            //     );
            //   },
            // ),
            child: AsiaSandbox(trips: trips,),
          )
        ],
      ),
    );
  }
}
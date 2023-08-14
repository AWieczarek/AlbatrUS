import 'package:albatrus/dashboard/date-format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/trip.dart';

class Details extends StatelessWidget {
  final Trip trip;

  Details({super.key,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Trip Details' ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 0.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          trip.country,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 0.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          trip.city,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 0.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          trip.description,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding:const EdgeInsets.fromLTRB(0,0,5,0),
                    child: Flexible(
                      child: Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              border: Border.all(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DateWidget(date: trip.dateFrom))),
                      ),
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.fromLTRB(5,0,0,0),
                    child: Flexible(
                      child: Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              border: Border.all(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: DateWidget(date: trip.dateTo))),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(vertical: 20, horizontal: 0.0),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(35)),
                    border: Border.all(
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                  child: Padding(
                      padding:const EdgeInsets.symmetric(vertical: 10, horizontal: 15.0),
                      child: Text(
                          style: const TextStyle(fontSize: 24),
                          '${trip.rate}'))),
            ),
          ],
        ),
      ),
    );
  }
}

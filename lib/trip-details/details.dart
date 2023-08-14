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
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      'country ${trip.country}',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      'city ${trip.city}',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(25)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: const Text(
                      'description',
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text('from')),
                  ),
                ),
                Flexible(
                  child: Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: const Text('to')),
                  ),
                ),
              ],
            ),
            Flex(
              direction: Axis.horizontal,
              children: [
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: const Text('rating')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

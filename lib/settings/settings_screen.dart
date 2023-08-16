import 'package:flutter/material.dart';

import '../custom_colors.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const route = 'settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  DistanceUnit _selectedDistanceUnit = DistanceUnit.meter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: CustomColors().backgroundColor,
      ),
      backgroundColor: CustomColors().backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distance Unit:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            RadioListTile<DistanceUnit>(
              title: const Text('Feet',
                style: TextStyle(color: Colors.white),
              ),
              value: DistanceUnit.feet,
              groupValue: _selectedDistanceUnit,
              onChanged: (value) {
                setState(() {
                  _selectedDistanceUnit = value!;
                });
              },
              fillColor: MaterialStateColor.resolveWith((states) => CustomColors().textColor),
            ),
            RadioListTile<DistanceUnit>(
              title: const Text('Meter',
                style: TextStyle(color: Colors.white),
              ),
              value: DistanceUnit.meter,
              groupValue: _selectedDistanceUnit,
              onChanged: (value) {
                setState(() {
                  _selectedDistanceUnit = value!;
                });
              },
              fillColor: MaterialStateColor.resolveWith((states) => CustomColors().textColor),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Text(
                  'Notifications:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(width: 10),
                Switch(
                  value: false,
                  onChanged: null,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum DistanceUnit {
  feet,
  meter,
}

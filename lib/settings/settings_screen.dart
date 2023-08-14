import 'package:flutter/material.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const route = 'settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  DistanceUnit _selectedDistanceUnit = DistanceUnit.meter;

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.toString()),
            const Text(
              'Distance Unit:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            RadioListTile<DistanceUnit>(
              title: const Text('Feet'),
              value: DistanceUnit.feet,
              groupValue: _selectedDistanceUnit,
              onChanged: (value) {
                setState(() {
                  _selectedDistanceUnit = value!;
                });
              },
            ),
            RadioListTile<DistanceUnit>(
              title: const Text('Meter'),
              value: DistanceUnit.meter,
              groupValue: _selectedDistanceUnit,
              onChanged: (value) {
                setState(() {
                  _selectedDistanceUnit = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Notifications:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 10),
                Switch(
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
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

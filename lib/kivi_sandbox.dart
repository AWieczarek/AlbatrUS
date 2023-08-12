import 'package:flutter/material.dart';


class KiviSandbox extends StatelessWidget {
  const KiviSandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Kivi Sandbox'),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Kochać',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 10),
              Text(
                'Adama',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              Text(
                'poniżej pleców',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
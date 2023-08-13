import 'package:albatrus/dashboard/dashboard-item.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AsiaSandbox());
}

class AsiaSandbox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DashboardItem(
      name: 'asia',
      date: DateTime.now(),
      place: 'radom',
    );
  }
}

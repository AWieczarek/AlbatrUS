import 'package:albatrus/api_routes.dart';
import 'package:albatrus/dashboard/asia_sandbox.dart';
import 'package:albatrus/database_service.dart';
import 'package:albatrus/models/trip.dart';
import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Trip>>(
        future: DatabaseService.fetchTrips(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            return AsiaSandbox(trips: snapshot.data!,);
          } else {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
        },
      ),
    );
  }
}

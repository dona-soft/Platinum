import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:platinum/models/workout_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Workout> workout;

  ///Needs an update for the Api URL
  Future<Workout> fetchWorkout() async {
    final response = await http.get(Uri.parse('www.google.com'));
    if (response.statusCode == 200) {
      return Workout.fromMap(jsonDecode(response.body));
    } else {
      //Err...
      throw Exception('Error loading data...');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    workout = fetchWorkout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platinum'),
      ),
      body: Center(
        child: FutureBuilder<Workout>(
          future: workout,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return const Text('OK');
            } else if (snapshot.hasError) {
              return const Text('an error happened!!');
            }
            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:journeyX/autj_view/splash_sacreen.dart';
import 'package:journeyX/autj_view/trip_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TripDaetails());
  }
}

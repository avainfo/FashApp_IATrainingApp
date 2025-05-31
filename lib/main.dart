import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ia_training_app/data/looks/looks_repository.dart';
import 'package:ia_training_app/firebase_options.dart';
import 'package:ia_training_app/pages/home_page.dart';
import 'package:ia_training_app/pages/landing_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  runApp(const MyApp());
}

Future<LookGender?> getSavedGender() async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getString('selected_gender');
  if (value == 'men') return LookGender.men;
  if (value == 'women') return LookGender.women;
  return null;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Look Selector',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<LookGender?>(
        future: getSavedGender(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (snapshot.data == null) {
            return const LandingPage();
          }
          return HomePage(gender: snapshot.data!);
        },
      ),
    );
  }
}

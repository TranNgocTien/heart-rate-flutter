import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:measure_heart/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Heart Rate',
      home: Home(),
    );
  }
}

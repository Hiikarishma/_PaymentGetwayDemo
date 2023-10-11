import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
        Locale('de', ''),
      ],
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
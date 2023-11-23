import 'package:flutter/material.dart';
import 'package:wakeup/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WakeUp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF272D34),
        textTheme: Theme.of(context)
            .textTheme
            .copyWith(
              bodyMedium: const TextStyle(fontFamily: "ClockFont"),
            )
            .apply(),
      ),
      home: const HomePage(),
    );
  }
}

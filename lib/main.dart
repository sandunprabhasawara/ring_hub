import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:musicapp/screens/tab_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Important for some plugins
  runApp(ProviderScope(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark).copyWith(
          textTheme: const TextTheme()
              .copyWith(bodyLarge: const TextStyle(color: Colors.white)),
          brightness: Brightness.dark),
      home: const TabScreen(),
    ),
  ));
}

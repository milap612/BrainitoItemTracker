import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/item_provider.dart';
import 'screen/item_tracker_screen.dart';
import 'utils/app_strings.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ItemProvider(),
    child: const ItemTrackerApp(),
  ));
}

class ItemTrackerApp extends StatelessWidget {
  const ItemTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.itemTracker,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          shadowColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          color: Colors.blue,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.normal,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ItemTrackerScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import './pages/weatherpage.dart';
import 'package:provider/provider.dart';
import './theme/custom_colors.dart';
import './providers/theme_provider.dart';
import './providers/temperature_unit_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ChangeNotifierProvider(create: (_) => TemperatureUnitProvider())
    ],
    child: MyApp(),
    )
  );
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  cardColor: Colors.white,
  primaryColor: Colors.white,
  useMaterial3: true,
  extensions: [
    CustomColors(
      searchBarColor: const Color.fromARGB(255, 245, 245, 245),  // Light grey for searchbar
      midInfoColor: const Color.fromARGB(255, 245, 245, 245),    // Slightly darker grey for mid info
      bottomInfoColor: const Color.fromARGB(255, 245, 245, 245)
    )
  ]
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 50, 50, 50),
  cardColor: const Color.fromARGB(255, 50, 50, 50),
  extensions: [
    CustomColors(
      searchBarColor: const Color.fromARGB(255, 56, 56, 56),    // Dark grey for searchbar
      midInfoColor: const Color.fromARGB(255, 56, 56, 56),      // Slightly darker for mid info
      bottomInfoColor: const Color.fromARGB(255, 56, 56, 56),
    )
  ]
  // More dark theme properties here
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeProvider.themeMode,
          home: WeatherPage(),
        );
      } 
    ,);
  }
}
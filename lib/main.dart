import 'package:flutter/material.dart';
import './pages/weatherpage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => ThemeProvider(),
    child: MyApp(),
    )
    );
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  cardColor: Colors.white,
  primaryColor: Colors.white,
  // scaffoldBackgroundColor: Colors.white,
  // appBarTheme: AppBarTheme(
  //   backgroundColor: Colors.white
  // ),
  // inputDecorationTheme: InputDecorationTheme(
  //   fillColor: const Color.fromARGB(255, 255, 255, 255),
  //   // filled: true
  // ),
  // More light theme properties here
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 50, 50, 50),
  cardColor: const Color.fromARGB(255, 50, 50, 50),
  // More dark theme properties here
);

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

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
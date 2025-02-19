import 'package:flutter/material.dart';

enum TemperatureUnit {
  celcius,
  fahrenheit,
  kelvin
}

class TemperatureUnitProvider with ChangeNotifier {
  TemperatureUnit _unit = TemperatureUnit.celcius;

  TemperatureUnit get unit => _unit;

  double convertTemperature(double temp) {
    switch(_unit){
      case TemperatureUnit.celcius:
        return temp;
      
      case TemperatureUnit.fahrenheit:
        return (temp*9/5) + 32;

      case TemperatureUnit.kelvin:
        return (temp+273);
    }
  }
//wip
  // String get unitSymbol(_unit){

  // }
}
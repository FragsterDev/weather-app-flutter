import 'package:flutter/material.dart';
// import 'package:weather_app/widgets/midinfo.dart';

@immutable
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? searchBarColor;
  final Color? midInfoColor;
  final Color? bottomInfoColor;
  

  const CustomColors({
    required this.searchBarColor,
    required this.midInfoColor,
    required this.bottomInfoColor
  });

  @override
  CustomColors copyWith({
    Color? searchBarColor,
    Color? midInfoColor,
    Color? bottomInfoColor,
  }) {
    return CustomColors(
            searchBarColor: searchBarColor ?? this.searchBarColor,
            midInfoColor: midInfoColor ?? this.midInfoColor,
            bottomInfoColor: bottomInfoColor ?? this.bottomInfoColor,
        );
  }
  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t){
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      searchBarColor: Color.lerp(searchBarColor, other.searchBarColor, t),
      midInfoColor: Color.lerp(searchBarColor, other.searchBarColor, t),
      bottomInfoColor: Color.lerp(searchBarColor, other.searchBarColor, t),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/temperature_unit_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override

  //wip
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final tempUnitProvider = Provider.of<TemperatureUnitProvider>(context);
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.fromLTRB(2, 20, 0, 0),
        children: [
          // const DrawerHeader(child: Text('Drawer Header'))
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Settings',style: TextStyle(fontSize: 22),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Theme', style: TextStyle(fontSize: 20),),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark, 
                  onChanged: (_) {
                    themeProvider.toggleTheme();
                  }
                ),
              ],
            ),
          ),
                    Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Unit', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 8),
                SegmentedButton<TemperatureUnit>(
                  segments: const [
                    ButtonSegment<TemperatureUnit>(
                      value: TemperatureUnit.celcius,
                      label: Text('°C'),
                    ),
                    ButtonSegment<TemperatureUnit>(
                      value: TemperatureUnit.fahrenheit,
                      label: Text('°F'),
                    ),
                    ButtonSegment<TemperatureUnit>(
                      value: TemperatureUnit.kelvin,
                      label: Text('K'),
                    ),
                  ],
                  selected: {tempUnitProvider.unit},
                  onSelectionChanged: (Set<TemperatureUnit> newSelection) {
                    tempUnitProvider.setUnit(newSelection.first);
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.selected)) {
                          return Colors.orange;
                        }
                        return Colors.transparent;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
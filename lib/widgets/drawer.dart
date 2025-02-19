import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override

  
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
          )
        ],
      ),
    );
  }
}
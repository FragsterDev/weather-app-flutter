import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  const Searchbar({super.key});

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: 370,
              child: const SearchBar(
                trailing: <Widget>[
                  IconButton(onPressed: null, icon: Icon(Icons.search),),
                ],
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 240, 240, 240),),
                hintText: 'Search Location',
                hintStyle: WidgetStatePropertyAll(TextStyle(
                  color: Color.fromARGB(255, 182, 182, 182),
                ),
                ),
              ),
            );
  }
}
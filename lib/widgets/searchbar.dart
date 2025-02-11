import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {

  final Function(String) onCityChanged;

  const Searchbar({Key? key, required this.onCityChanged}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _controller = TextEditingController();

  void _submitSearch(){
    if(_controller.text.isNotEmpty){
      widget.onCityChanged(_controller.text.trim()); //notify parent widget
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              width: 370,
              child: SearchBar(
                controller: _controller,
                trailing: <Widget>[
                  IconButton(onPressed: _submitSearch, icon: Icon(Icons.search),),
                ],
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 240, 240, 240),),
                hintText: 'Search Location',
                hintStyle: WidgetStatePropertyAll(TextStyle(
                  color: Color.fromARGB(255, 182, 182, 182),
                ),
                ),
                onSubmitted: (_) => _submitSearch,
              ),
            );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:shared_preferences/shared_preferences.dart';  // Import shared preferences for storing data
// import '../services/weather_service.dart';  // Assuming WeatherService is for fetching weather data

// class Searchbar extends StatefulWidget {
//   final Function(String) onCityChanged;
//   final Future<void> Function() onCurrentLocationTapped;

//   const Searchbar({Key? key, required this.onCityChanged, required this.onCurrentLocationTapped}) : super(key: key);

//   @override
//   State<Searchbar> createState() => _SearchbarState();
// }

// class _SearchbarState extends State<Searchbar> {
//   final TextEditingController _controller = TextEditingController();
//   List<String> _searchedCities = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadSearchedCities();  // Load previously searched cities on app startup
//   }

//   // Load the last 4 searched cities from SharedPreferences
//   _loadSearchedCities() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _searchedCities = prefs.getStringList('searchedCities') ?? [];
//     });
//   }

//   // Save the list of cities to SharedPreferences (only keep 4 unique cities)
//   _saveSearchedCities() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('searchedCities', _searchedCities);
//   }

//   // Add a city to the list of searched cities
//   void _addToSearchedCities(String city) {
//     setState(() {
//       if (!_searchedCities.contains(city)) {
//         _searchedCities.insert(0, city);  // Add at the beginning of the list
//         if (_searchedCities.length > 4) {
//           _searchedCities.removeLast();  // Keep only 4 cities
//         }
//       }
//     });
//     _saveSearchedCities();  // Save the updated list
//   }

//   // Fetch city suggestions from WeatherService
//   Future<List<String>> _getSuggestions(String query) async {
//     if (query.isEmpty) {
//       return _searchedCities;  // Return the last 4 cities if the query is empty
//     }
//     return await WeatherService().fetchCitySuggestions(query);  // Fetch suggestions from WeatherService (or use Google Places API)
//   }

//   // Trigger the search on submit
//   void _submitSearch() {
//     String city = _controller.text.trim();
//     if (city.isNotEmpty) {
//       widget.onCityChanged(city); // Notify parent widget with the selected city
//       _addToSearchedCities(city); // Save this city to the list of searched cities
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 370,
//       child: Column(
//         children: [
//           if (_controller.text.isEmpty) 
//             ListTile(
//               onTap: () {
//                 widget.onCurrentLocationTapped(); // Call the callback function when the button is tapped
//               },
//               leading: Icon(Icons.location_on),  // Crosshair icon for location
//               title: Text('Use Current Location'),
//             ),
//           TypeAheadField<String>(
//             textFieldConfiguration: TextFieldConfiguration(
//               controller: _controller,
//               decoration: InputDecoration(
//                 hintText: 'Search Location',
//                 hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
//                 filled: true,
//                 fillColor: Color.fromARGB(255, 240, 240, 240),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30), // Rounded corners
//                 ),
//                 suffixIcon: IconButton(
//                   onPressed: _submitSearch, // Trigger search on button press
//                   icon: Icon(Icons.search),
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             suggestionsCallback: (query) {
//               if (query.isEmpty) {
//                 // Returning _searchedCities when query is empty
//                 return _searchedCities; // Return previously searched cities
//               }
          
//               // Filter the previous searched cities based on the query
//               List<String> filteredCities = _searchedCities.where((city) {
//                 return city.toLowerCase().contains(query.toLowerCase());
//               }).toList();
          
//               if (filteredCities.isNotEmpty) {
//                 return filteredCities; // Return filtered cities that match the query
//               }
          
//               // If no match, call external service (fetch city suggestions)
//               return _getSuggestions(query);
//             },
//             itemBuilder: (context, String suggestion) {
//               return ListTile(
//                 title: Text(suggestion),
//               );
//             },
//             onSuggestionSelected: (String selectedCity) {
//               _controller.text = selectedCity;
//               _submitSearch(); // Trigger city change when a suggestion is selected
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/weather_service.dart';

class Searchbar extends StatefulWidget {
  final Function(String) onCityChanged;
  final Future<void> Function() onCurrentLocationTapped;

  const Searchbar({
    Key? key, 
    required this.onCityChanged, 
    required this.onCurrentLocationTapped
  }) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<String> _searchedCities = [];
  bool _isInputFocused = false;

  @override
  void initState() {
    super.initState();
    _loadSearchedCities();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isInputFocused = _focusNode.hasFocus;
    });
  }

  // Load the last 4 searched cities from SharedPreferences
  _loadSearchedCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchedCities = prefs.getStringList('searchedCities') ?? [];
    });
  }

  // Save the list of cities to SharedPreferences (only keep 4 unique cities)
  _saveSearchedCities() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('searchedCities', _searchedCities);
  }

  void _addToSearchedCities(String city) {
    setState(() {
      if (!_searchedCities.contains(city)) {
        _searchedCities.insert(0, city);
        if (_searchedCities.length > 4) {
          _searchedCities.removeLast();
        }
      }
    });
    _saveSearchedCities();
  }

  Future<List<String>> _getSuggestions(String query) async {
    if (query.isEmpty) {
      return _searchedCities;
    }
    return await WeatherService().fetchCitySuggestions(query);
  }

  void _submitSearch() {
    String city = _controller.text.trim();
    if (city.isNotEmpty) {
      widget.onCityChanged(city);
      _addToSearchedCities(city);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: Column(
        children: [
          TypeAheadField<String>(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _controller,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: 'Search Location',
                hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
                filled: true,
                fillColor: Color.fromARGB(255, 240, 240, 240),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: IconButton(
                  onPressed: _submitSearch,
                  icon: Icon(Icons.search),
                  color: Colors.black,
                ),
              ),
            ),
            suggestionsCallback: (query) async {
              if (_isInputFocused && query.isEmpty) {
                // Show current location button as first item
                return ['__current_location__', ..._searchedCities];
              }
              
              if (query.isEmpty) {
                return _searchedCities;
              }

              List<String> filteredCities = _searchedCities
                  .where((city) => city.toLowerCase().contains(query.toLowerCase()))
                  .toList();

              if (filteredCities.isNotEmpty) {
                return filteredCities;
              }

              return _getSuggestions(query);
            },
            itemBuilder: (context, String suggestion) {
              if (suggestion == '__current_location__') {
                return ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text('Use Current Location'),
                );
              }
              return ListTile(
                title: Text(suggestion),
              );
            },
            onSuggestionSelected: (String selectedCity) {
              if (selectedCity == '__current_location__') {
                widget.onCurrentLocationTapped();
                return;
              }
              _controller.text = selectedCity;
              _submitSearch();
            },
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../services/weather_service.dart';

// class Searchbar extends StatefulWidget {
//   final Function(String) onCityChanged;
//   final Future<void> Function() onCurrentLocationTapped;

//   const Searchbar({
//     Key? key, 
//     required this.onCityChanged, 
//     required this.onCurrentLocationTapped
//   }) : super(key: key);

//   @override
//   State<Searchbar> createState() => _SearchbarState();
// }

// class _SearchbarState extends State<Searchbar> {
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   List<String> _searchedCities = [];
//   bool _isInputFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadSearchedCities();
//     _focusNode.addListener(_onFocusChange);
//   }

//   @override
//   void dispose() {
//     _focusNode.removeListener(_onFocusChange);
//     _focusNode.dispose();
//     _controller.dispose();
//     super.dispose();
//   }

//   void _onFocusChange() {
//     setState(() {
//       _isInputFocused = _focusNode.hasFocus;
//     });
//   }

//   _loadSearchedCities() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _searchedCities = prefs.getStringList('searchedCities') ?? [];
//     });
//   }

//   _saveSearchedCities() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setStringList('searchedCities', _searchedCities);
//   }

//   void _addToSearchedCities(String city) {
//     setState(() {
//       if (!_searchedCities.contains(city)) {
//         _searchedCities.insert(0, city);
//         if (_searchedCities.length > 4) {
//           _searchedCities.removeLast();
//         }
//       }
//     });
//     _saveSearchedCities();
//   }

//   Future<List<String>> _getSuggestions(String query) async {
//     if (query.isEmpty) {
//       return _searchedCities;
//     }
//     return await WeatherService().fetchCitySuggestions(query);
//   }

//   void _submitSearch() {
//     String city = _controller.text.trim();
//     if (city.isNotEmpty) {
//       widget.onCityChanged(city);
//       _addToSearchedCities(city);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 370,
//       child: Column(
//         children: [
//           // Show current location button directly in the Column
//           if (_isInputFocused && _controller.text.isEmpty)
//             Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   widget.onCurrentLocationTapped();
//                   _focusNode.unfocus(); // Unfocus the text field after selection
//                 },
//                 child: ListTile(
//                   leading: Icon(Icons.location_on),
//                   title: Text('Use Current Location'),
//                 ),
//               ),
//             ),
//           TypeAheadField<String>(
//             textFieldConfiguration: TextFieldConfiguration(
//               controller: _controller,
//               focusNode: _focusNode,
//               decoration: InputDecoration(
//                 hintText: 'Search Location',
//                 hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
//                 filled: true,
//                 fillColor: Color.fromARGB(255, 240, 240, 240),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 suffixIcon: IconButton(
//                   onPressed: _submitSearch,
//                   icon: Icon(Icons.search),
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             suggestionsCallback: (query) async {
//               if (query.isEmpty) {
//                 return _searchedCities;
//               }

//               List<String> filteredCities = _searchedCities
//                   .where((city) => city.toLowerCase().contains(query.toLowerCase()))
//                   .toList();

//               if (filteredCities.isNotEmpty) {
//                 return filteredCities;
//               }

//               return _getSuggestions(query);
//             },
//             itemBuilder: (context, String suggestion) {
//               return ListTile(
//                 title: Text(suggestion),
//               );
//             },
//             onSuggestionSelected: (String selectedCity) {
//               _controller.text = selectedCity;
//               _submitSearch();
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
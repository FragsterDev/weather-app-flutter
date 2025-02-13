import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';  // Import shared preferences for storing data
import '../services/weather_service.dart';  // Assuming WeatherService is for fetching weather data

class Searchbar extends StatefulWidget {
  final Function(String) onCityChanged;

  const Searchbar({Key? key, required this.onCityChanged}) : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  final TextEditingController _controller = TextEditingController();
  List<String> _searchedCities = [];

  @override
  void initState() {
    super.initState();
    _loadSearchedCities();  // Load previously searched cities on app startup
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

  // Add a city to the list of searched cities
  void _addToSearchedCities(String city) {
    setState(() {
      if (!_searchedCities.contains(city)) {
        _searchedCities.insert(0, city);  // Add at the beginning of the list
        if (_searchedCities.length > 4) {
          _searchedCities.removeLast();  // Keep only 4 cities
        }
      }
    });
    _saveSearchedCities();  // Save the updated list
  }

  // Fetch city suggestions from WeatherService
  Future<List<String>> _getSuggestions(String query) async {
    if (query.isEmpty) {
      return _searchedCities;  // Return the last 4 cities if the query is empty
    }
    return await WeatherService().fetchCitySuggestions(query);  // Fetch suggestions from WeatherService (or use Google Places API)
  }

  // Trigger the search on submit
  void _submitSearch() {
    String city = _controller.text.trim();
    if (city.isNotEmpty) {
      widget.onCityChanged(city); // Notify parent widget with the selected city
      _addToSearchedCities(city); // Save this city to the list of searched cities
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 370,
      child: TypeAheadField<String>(
        textFieldConfiguration: TextFieldConfiguration(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search Location',
            hintStyle: TextStyle(color: Color.fromARGB(255, 182, 182, 182)),
            filled: true,
            fillColor: Color.fromARGB(255, 240, 240, 240),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            suffixIcon: IconButton(
              onPressed: _submitSearch, // Trigger search on button press
              icon: Icon(Icons.search),
              color: Colors.black,
            ),
          ),
        ),
        suggestionsCallback: (query) {
          if (query.isEmpty) {
            // Returning _searchedCities when query is empty
            return _searchedCities; // Return previously searched cities
          }

          // Filter the previous searched cities based on the query
          List<String> filteredCities = _searchedCities.where((city) {
            return city.toLowerCase().contains(query.toLowerCase());
          }).toList();

          if (filteredCities.isNotEmpty) {
            return filteredCities; // Return filtered cities that match the query
          }

          // If no match, call external service (fetch city suggestions)
          return _getSuggestions(query);
        },
        itemBuilder: (context, String suggestion) {
          return ListTile(
            title: Text(suggestion),
          );
        },
        onSuggestionSelected: (String selectedCity) {
          _controller.text = selectedCity;
          _submitSearch(); // Trigger city change when a suggestion is selected
        },
      ),
    );
  }
}

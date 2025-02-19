import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/theme/custom_colors.dart';
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
    print(Theme.of(context).cardColor);
    print(Theme.of(context).primaryColor);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0,17,0,0),
      child: SizedBox(
        width: 370,
        child: Column(
          children: [
            TypeAheadField<String>(
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                elevation: 0,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(15), right: Radius.circular(15)),
                color: Theme.of(context).primaryColor,
              ),
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: 'Search Location',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 196, 196, 196)),
                  filled: true,
                  fillColor: Theme.of(context).extension<CustomColors>()?.searchBarColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none
                  ),
                  suffixIcon: IconButton(
                    onPressed: _submitSearch,
                    icon: Icon(Icons.search),
                    color: Color.fromARGB(255, 196, 196, 196),
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
      ),
    );
  }
}
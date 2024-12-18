import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class RestaurantsListCuisineTypeDropdown extends StatefulWidget {
  final Map<String, String> cuisineTypeMap;
  final String? selectedCuisineType;
  final ValueChanged<String?> onChanged;

  const RestaurantsListCuisineTypeDropdown({
    Key? key,
    required this.cuisineTypeMap,
    required this.selectedCuisineType,
    required this.onChanged,
  }) : super(key: key);

  @override
  _RestaurantsListCuisineTypeDropdownState createState() =>
      _RestaurantsListCuisineTypeDropdownState();
}

class _RestaurantsListCuisineTypeDropdownState
    extends State<RestaurantsListCuisineTypeDropdown> {
  late String? _selectedCuisineType;
  List<String> cuisineTypes = ['All']; // Default 'All' option
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedCuisineType = widget.selectedCuisineType ?? 'All';
    getCuisineTypes();
  }

  // Fetch cuisine types from the API
  Future<void> getCuisineTypes() async {
    setState(() {
      isLoading = true; // Start loading
    });

    try {
      String url = 'http://localhost:5000/api/cuisinetypes';
      final response = await http.get(Uri.parse(url));
      debugPrint('Cuisine Types API Response: ${response.body}');
      if (response.statusCode == 200) {
        final cuisineData = json.decode(response.body);
        List<String> fetchedCuisineTypes = ['All'];
        for (var cuisine in cuisineData['cuisineTypes']) {
          fetchedCuisineTypes.add(cuisine['id'].toString());
          widget.cuisineTypeMap[cuisine['id'].toString()] = cuisine['name'];
        }
        setState(() {
          cuisineTypes = fetchedCuisineTypes;
        });
        debugPrint('Cuisine Types Updated: $cuisineTypes');
      } else {
        debugPrint('Error fetching cuisine types: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception fetching cuisine types: $e');
    } finally {
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = _selectedCuisineType != 'All';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: _showCuisineDropdown,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Cuisine Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.green : Colors.black,
                      ),
                    ),
                    SizedBox(width: 8),
                    Transform.rotate(
                      angle: -3.14159 / 2,
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                        size: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCuisineDropdown() async {
    final selectedValue = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        0,
        100,
        0,
        0,
      ),
      items: cuisineTypes.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(value == 'All'
                  ? 'All'
                  : widget.cuisineTypeMap[value] ?? 'Unknown'),
              if (value == _selectedCuisineType)
                Icon(
                  Icons.check,
                  size: 18,
                  color: Colors.green,
                ),
            ],
          ),
        );
      }).toList(),
    );

    if (selectedValue != null) {
      setState(() {
        _selectedCuisineType = selectedValue;
      });
      widget.onChanged(selectedValue);
    }
  }
}

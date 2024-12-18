import 'package:flutter/material.dart';

class RestaurantsListCuisineTypeDropdown extends StatelessWidget {
  final List<String> cuisineTypes;
  final Map<String, String> cuisineTypeMap;
  final String? selectedCuisineType;
  final ValueChanged<String?> onChanged;

  const RestaurantsListCuisineTypeDropdown({
    Key? key,
    required this.cuisineTypes,
    required this.cuisineTypeMap,
    required this.selectedCuisineType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: selectedCuisineType ?? 'All',
        onChanged: onChanged,
        items: cuisineTypes.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
                value == 'All' ? 'All' : cuisineTypeMap[value] ?? 'Unknown'),
          );
        }).toList(),
      ),
    );
  }
}

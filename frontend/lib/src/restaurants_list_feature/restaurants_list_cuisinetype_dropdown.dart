import 'package:flutter/material.dart';

class RestaurantsListCuisineTypeDropdown extends StatefulWidget {
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
  _RestaurantsListCuisineTypeDropdownState createState() =>
      _RestaurantsListCuisineTypeDropdownState();
}

class _RestaurantsListCuisineTypeDropdownState
    extends State<RestaurantsListCuisineTypeDropdown> {
  late String? _selectedCuisineType;
  final GlobalKey _labelKey = GlobalKey(); // Initialize the key here

  @override
  void initState() {
    super.initState();
    _selectedCuisineType = widget.selectedCuisineType ?? 'All';
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = _selectedCuisineType != 'All';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align label to the left
        children: [
          // Align the whole box to the left
          Align(
            alignment: Alignment.centerLeft, // Align the box to the left
            child: GestureDetector(
              key: _labelKey, // Assign the GlobalKey to the GestureDetector
              onTap:
                  _showCuisineDropdown, // Open the dropdown when the label is tapped
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors
                      .grey[200], // Background color for the label and arrow
                  borderRadius:
                      BorderRadius.circular(8), // Optional: rounded corners
                ),
                child: Row(
                  mainAxisSize: MainAxisSize
                      .min, // This ensures the box wraps its content
                  children: [
                    // Label with dynamic color based on selection
                    Text(
                      'Cuisine Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.green
                            : Colors.black, // Color changes when selected
                      ),
                    ),
                    SizedBox(
                        width: 8), // Add some space between label and arrow
                    // Arrow icon rotated to point downwards
                    Transform.rotate(
                      angle: -3.14159 /
                          2, // Rotate 180 degrees (π radians) to point backwards
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded, // The arrow icon
                        color: Colors.black,
                        size: 12, // Make the icon smaller
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

  // Function to show the dropdown when the label is tapped
  void _showCuisineDropdown() async {
    final RenderBox renderBox =
        _labelKey.currentContext!.findRenderObject() as RenderBox;
    final offset =
        renderBox.localToGlobal(Offset.zero); // Get the position of the label

    final selectedValue = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx - renderBox.size.width, // Align to the left of the label
        offset.dy + renderBox.size.height + 8, // Y position (below the label)
        0, // Right position (no need to change)
        0, // Bottom position (no need to change)
      ),
      items: widget.cuisineTypes.map((String value) {
        return PopupMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Text(
                value == 'All'
                    ? 'All'
                    : widget.cuisineTypeMap[value] ?? 'Unknown',
              ),
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

    // If the user selects a value, update the state
    if (selectedValue != null) {
      setState(() {
        _selectedCuisineType = selectedValue;
      });
      widget.onChanged(selectedValue);
    }
  }
}

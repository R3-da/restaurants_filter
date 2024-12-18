import 'package:flutter/material.dart';
import 'restaurants_list_item.dart';
import 'restaurants_list_cuisinetype_dropdown.dart'; // Import your custom dropdown widget

class RestaurantsListView extends StatelessWidget {
  final List? restaurants;
  final Map<String, String> cuisineTypeMap;
  final String? selectedCuisineType;
  final bool isLoading;
  final Function(int) onItemTap;
  final Function(String?) onCuisineTypeChanged; // Add this parameter

  const RestaurantsListView({
    Key? key,
    required this.restaurants,
    required this.cuisineTypeMap,
    required this.selectedCuisineType,
    required this.isLoading,
    required this.onItemTap,
    required this.onCuisineTypeChanged, // Initialize onCuisineTypeChanged here
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar for the image at the top
        SliverAppBar(
          surfaceTintColor: Colors.grey[900],
          backgroundColor: Colors.grey[900],
          expandedHeight: 250.0, // Height of the image
          pinned: true, // Keeps the app bar visible when scrolling
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              'Restaurants List', // This will become the title in the sticky bar
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            background: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/sliver_food_image.jpg',
                  fit: BoxFit.cover,
                ),
                // Gradient overlay from dark at the bottom to transparent at the top
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment
                          .bottomCenter, // Start gradient at the bottom
                      end: Alignment.topCenter, // End gradient at the top
                      colors: [
                        Colors.grey[900]!
                            .withOpacity(0.9), // Dark at the bottom
                        Colors.grey[900]!
                            .withOpacity(0), // Transparent at the top
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Cuisine type dropdown inside a white bar
        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyHeaderDelegate(
            child: Container(
              color: Colors.grey[900], // White background for the bar
              padding: EdgeInsets.all(0.0), // Padding for spacing
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Align dropdown to the bottom
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align to the left
                children: [
                  RestaurantsListCuisineTypeDropdown(
                    cuisineTypeMap: cuisineTypeMap,
                    selectedCuisineType: selectedCuisineType,
                    onChanged: onCuisineTypeChanged, // Pass the callback
                  ),
                ],
              ),
            ),
          ),
        ),
        // List of restaurants
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              final restaurant = restaurants?[index];
              final cuisineTypeName =
                  cuisineTypeMap[restaurant?["cuisineTypeId"].toString()];

              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 8.0), // Horizontal padding
                child: Column(
                  children: [
                    RestaurantListItem(
                      restaurant: restaurant,
                      cuisineTypeName: cuisineTypeName,
                      onTap: () => onItemTap(index),
                    ),
                    const SizedBox(height: 8.0), // Gap between items
                  ],
                ),
              );
            },
            childCount: restaurants?.length ?? 0,
          ),
        ),
      ],
    );
  }
}

// Custom delegate for the sticky header
class _StickyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _StickyHeaderDelegate({required this.child});

  @override
  double get minExtent => 60.0; // Minimum height of the header
  @override
  double get maxExtent => 60.0; // Maximum height of the header

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

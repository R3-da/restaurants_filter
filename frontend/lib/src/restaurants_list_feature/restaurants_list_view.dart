import 'package:flutter/material.dart';
import 'restaurants_list_item.dart';

class RestaurantsListView extends StatelessWidget {
  final List? restaurants;
  final Map<String, String> cuisineTypeMap;
  final Function(int) onItemTap;

  const RestaurantsListView({
    Key? key,
    required this.restaurants,
    required this.cuisineTypeMap,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar for the image at the top
        SliverAppBar(
          expandedHeight: 250.0, // Height of the image
          pinned: true, // Keeps the app bar visible when scrolling
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              'assets/images/sliver_food_image.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Sticky label below the image
        SliverPersistentHeader(
          pinned: true, // Makes the label sticky
          delegate: _StickyHeaderDelegate(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Restaurants List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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

              return RestaurantListItem(
                restaurant: restaurant,
                cuisineTypeName: cuisineTypeName,
                onTap: () => onItemTap(index),
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

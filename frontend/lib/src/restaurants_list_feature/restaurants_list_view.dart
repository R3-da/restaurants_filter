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
    return ListView.builder(
      itemCount: restaurants == null ? 0 : restaurants?.length,
      itemBuilder: (BuildContext context, int index) {
        final restaurant = restaurants?[index];
        final cuisineTypeName =
            cuisineTypeMap[restaurant?["cuisineTypeId"].toString()];

        return RestaurantListItem(
          restaurant: restaurant,
          cuisineTypeName: cuisineTypeName,
          onTap: () => onItemTap(index),
        );
      },
    );
  }
}

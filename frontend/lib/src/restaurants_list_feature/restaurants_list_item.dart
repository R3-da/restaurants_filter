import 'package:flutter/material.dart';

class RestaurantListItem extends StatelessWidget {
  final Map<String, dynamic> restaurant;
  final String? cuisineTypeName;
  final VoidCallback onTap;

  const RestaurantListItem({
    Key? key,
    required this.restaurant,
    required this.cuisineTypeName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    restaurant['avatar'] ?? '',
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 120,
                      child: Text(
                        restaurant["name"] ?? 'Unknown',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      cuisineTypeName ?? 'Unknown',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

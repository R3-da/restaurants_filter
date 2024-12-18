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
        color: Colors.grey[850],
        margin: EdgeInsets.zero,
        elevation: 10, // Set elevation for shadow effect
        shadowColor: Colors
            .black, // Set the shadow color (this will work with elevation)
        child: Container(
          width: double.infinity, // Ensure the card takes up full width
          padding: const EdgeInsets.all(16.0), // Inner padding for content
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80, // Width of the square avatar frame
                height: 80, // Height of the square avatar frame
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle, // Make it square
                  borderRadius: BorderRadius.circular(4.0), // Rounded corners
                  image: DecorationImage(
                    image: NetworkImage(
                      restaurant['avatar'] ?? '',
                    ),
                    fit: BoxFit.cover, // Cover the area of the container
                  ),
                ),
              ),
              const SizedBox(width: 8), // Space between avatar and text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurant["name"] ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Prevents overflow in long names
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4),
                    // Add Row with map icon and location text
                    Row(
                      children: [
                        Icon(
                          Icons.map, // Map icon
                          color: Colors.green, // Customize the icon color
                          size: 20.0, // Adjust the icon size
                        ),
                        const SizedBox(
                            width: 8), // Space between the icon and text
                        Text(
                          restaurant["location"] ?? 'Location not available',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.white, // Customize the text color
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cuisineTypeName ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Prevents overflow in long text
                      maxLines: 1,
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

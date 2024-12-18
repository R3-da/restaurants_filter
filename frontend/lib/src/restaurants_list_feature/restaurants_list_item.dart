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
        elevation:
            6.0, // Adjust the elevation value for the desired shadow intensity
        shadowColor:
            Colors.black.withOpacity(0.2), // Optional: Customize shadow color
        shape: RoundedRectangleBorder(
          // Optional: Add rounded corners
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(
            horizontal: 8.0, vertical: 4.0), // Outer margin for spacing
        child: Container(
          width: double.infinity, // Ensure the card takes up full width
          padding: const EdgeInsets.all(12.0), // Inner padding for content
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 30, // Adjust the size of the avatar
                  backgroundImage: NetworkImage(
                    restaurant['avatar'] ?? '',
                  ),
                  backgroundColor:
                      Colors.grey[300], // Fallback color if no image
                ),
              ),
              const SizedBox(width: 10), // Space between avatar and text
              Expanded(
                // Ensures the text content fits within available space
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      restaurant["name"] ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Prevents overflow in long names
                      maxLines: 1,
                    ),
                    const SizedBox(height: 5),
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

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
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: 16.0, vertical: 8.0), // Outer margin for spacing
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.9), // Green shadow color
              spreadRadius: 2.0, // Spread the shadow
              blurRadius: 14.0, // Blur effect for the shadow
              offset: Offset(4.0, 4.0), // Shadow direction: bottom-right
            ),
            BoxShadow(
              color:
                  Colors.black.withOpacity(0.9), // Lighter shadow on the left
              spreadRadius: 2.0,
              blurRadius: 14.0,
              offset: Offset(-4.0, 4.0), // Shadow direction: bottom-left
            ),
          ],
        ),
        child: Card(
          elevation: 0, // Disable default elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Container(
            width: double.infinity, // Ensure the card takes up full width
            padding: const EdgeInsets.all(16.0), // Inner padding for content
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
      ),
    );
  }
}

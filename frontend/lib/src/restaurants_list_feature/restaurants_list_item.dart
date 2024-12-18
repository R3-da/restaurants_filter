import 'package:flutter/material.dart';

class RestaurantListItem extends StatefulWidget {
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
  _RestaurantListItemState createState() => _RestaurantListItemState();
}

class _RestaurantListItemState extends State<RestaurantListItem> {
  bool isLiked = false; // Track if the restaurant is liked

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
              // Avatar section
              Container(
                width: 80, // Width of the square avatar frame
                height: 80, // Height of the square avatar frame
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle, // Make it square
                  borderRadius: BorderRadius.circular(4.0), // Rounded corners
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.restaurant['avatar'] ?? '',
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
                    // Restaurant name
                    Text(
                      widget.restaurant["name"] ?? 'Unknown',
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
                    // Row with map icon and location text
                    Row(
                      children: [
                        Icon(
                          Icons.map, // Map icon
                          color: Colors.grey, // Customize the icon color
                          size: 20.0, // Adjust the icon size
                        ),
                        const SizedBox(
                            width: 8), // Space between the icon and text
                        Text(
                          widget.restaurant["location"] ??
                              'Location not available',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey, // Customize the text color
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    // Cuisine type
                    Text(
                      widget.cuisineTypeName ?? 'Unknown',
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
              // Right column with like button and rating
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Like button (Heart icon)
                  IconButton(
                    icon: Icon(
                      isLiked
                          ? Icons.favorite
                          : Icons
                              .favorite_border, // Toggle between filled and outlined heart
                      color: isLiked
                          ? Colors.red
                          : Colors.grey, // Change color based on isLiked state
                      size: 20.0, // Reduced icon size
                    ),
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked; // Toggle the like state
                      });
                    },
                  ),
                  // Star icon with average rating
                  Row(
                    children: [
                      Icon(
                        Icons.star, // Star icon
                        color: Colors.yellow,
                        size: 18.0,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.restaurant["averageRating"]
                                ?.toStringAsFixed(1) ??
                            '0.0',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

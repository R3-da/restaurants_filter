import 'package:flutter/material.dart';
import 'restaurants_list_feature/restaurants_list_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? restaurantsData;
  String? selectedCuisineType;
  Map<String, String> cuisineTypeMap =
      {}; // Map to store cuisine type ID to name
  bool isLoading = false;

  // Fetch restaurants data from the API based on the selected cuisine type
  Future<void> getRestaurants([String? cuisineId]) async {
    setState(() {
      isLoading = true;
    });

    try {
      String url = 'http://localhost:5000/api/restaurants';
      if (cuisineId != null && cuisineId != 'All') {
        url += '/$cuisineId';
      }
      final response = await http.get(Uri.parse(url));
      debugPrint('Restaurants API Response: ${response.body}');
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        setState(() {
          restaurantsData = responseBody['restaurants'] ?? [];
        });
      } else {
        debugPrint('Error fetching restaurants: ${response.statusCode}');
        setState(() {
          restaurantsData = [];
        });
      }
    } catch (e) {
      debugPrint('Exception fetching restaurants: $e');
      setState(() {
        restaurantsData = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Function to show a SnackBar with the restaurant's info
  void showRestaurantInfo(int index) {
    final String restaurantName = restaurantsData?[index]['name'] ?? 'Unknown';
    final String cuisineTypeId =
        restaurantsData?[index]['cuisineTypeId'].toString() ?? 'Unknown';
    final String avatar = restaurantsData?[index]['avatar'] ?? 'No Image';

    final String cuisineTypeName = cuisineTypeMap[cuisineTypeId] ?? 'Unknown';

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Restaurant: $restaurantName\nCuisine Type: $cuisineTypeName\nAvatar: $avatar',
          style: TextStyle(fontSize: 16),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getRestaurants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        children: [
          Expanded(
            child: RestaurantsListView(
              restaurants: restaurantsData,
              cuisineTypeMap: cuisineTypeMap,
              selectedCuisineType: selectedCuisineType,
              isLoading: isLoading,
              onItemTap: showRestaurantInfo,
              onCuisineTypeChanged: (String? newCuisineType) {
                setState(() {
                  selectedCuisineType = newCuisineType;
                });
                getRestaurants(newCuisineType);
              }, // Add the onCuisineTypeChanged callback here
            ),
          ),
        ],
      ),
    );
  }
}

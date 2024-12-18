import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map? data;
  List? restaurantsData;
  List<String> cuisineTypes = ['All']; // Default 'All' option
  String? selectedCuisineType;
  Map<String, String> cuisineTypeMap =
      {}; // Map to store cuisine type ID to name

  // Fetch restaurants data from the API based on the selected cuisine type
  getRestaurants([String? cuisine]) async {
    String url = 'http://localhost:5000/api/restaurants';
    if (cuisine != null && cuisine != 'All') {
      url += '?cuisineType=$cuisine'; // Add filter to the URL
    }
    http.Response response = await http.get(Uri.parse(url));
    data = json.decode(response.body);
    setState(() {
      restaurantsData = data?['restaurants']; // Change 'users' to 'restaurants'
    });
  }

  // Fetch cuisine types from the API
  getCuisineTypes() async {
    String url =
        'http://localhost:5000/api/cuisinetypes'; // API endpoint for cuisine types
    http.Response response = await http.get(Uri.parse(url));
    debugPrint(
        'Cuisine Types API Response: ${response.body}'); // Debugging response
    Map cuisineData = json.decode(response.body);
    List<String> fetchedCuisineTypes = ['All']; // Default 'All' option
    // Assuming the API returns a list of cuisine types
    for (var cuisine in cuisineData['cuisineTypes']) {
      fetchedCuisineTypes.add(cuisine['name']);
      cuisineTypeMap[cuisine['id'].toString()] =
          cuisine['name']; // Map ID to name
    }
    setState(() {
      cuisineTypes = fetchedCuisineTypes;
    });
  }

  @override
  void initState() {
    super.initState();
    getRestaurants(); // Get all restaurants initially
    getCuisineTypes(); // Fetch cuisine types
  }

  // Function to show a SnackBar with the restaurant's info
  void showRestaurantInfo(int index) {
    final String restaurantName = restaurantsData?[index]['name'] ?? 'Unknown';
    final String cuisineTypeId =
        restaurantsData?[index]['cuisineTypeId'].toString() ??
            'Unknown'; // Ensure it's a String
    final String avatar = restaurantsData?[index]['avatar'] ?? 'No Image';

    // Get the cuisine type name from the map
    final String cuisineTypeName = cuisineTypeMap[cuisineTypeId] ?? 'Unknown';

    // Debugging: Print the restaurant data and cuisineType name
    debugPrint(
        'Restaurant: $restaurantName, Cuisine Type Name: $cuisineTypeName');

    // Hide the previous SnackBar before showing the new one
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    // Display the Snackbar with restaurant information
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurants List'),
        backgroundColor: Colors.indigo[900],
      ),
      body: Column(
        children: [
          // Filter Dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedCuisineType ?? 'All',
              onChanged: (String? newValue) {
                setState(() {
                  selectedCuisineType = newValue;
                });
                getRestaurants(newValue); // Fetch data based on selected filter
              },
              items: cuisineTypes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Restaurant list
          Expanded(
            child: ListView.builder(
              itemCount: restaurantsData == null ? 0 : restaurantsData?.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () =>
                      showRestaurantInfo(index), // Show SnackBar on tap
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                restaurantsData?[index]['avatar'] ?? '',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Truncate the restaurant name with ellipsis if it's too long
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: Text(
                                    "${restaurantsData?[index]["name"]}",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w700),
                                    overflow: TextOverflow
                                        .ellipsis, // Handle overflow
                                    maxLines:
                                        1, // Ensure it doesn't take more than one line
                                  ),
                                ),
                                SizedBox(height: 5),
                                // Display the cuisine type name instead of ID
                                Text(
                                  "Cuisine Type: ${cuisineTypeMap[restaurantsData?[index]["cuisineTypeId"].toString()] ?? 'Unknown'}",
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
              },
            ),
          ),
        ],
      ),
    );
  }
}

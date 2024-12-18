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

  // Fetch restaurants data from the API based on the selected cuisine type
  getRestaurants([String? cuisine]) async {
    String url = 'http://localhost:5000/api/restaurants';
    if (cuisine != null && cuisine != 'All') {
      url += '?cuisineType=$cuisine'; // Add filter to the URL
    }
    http.Response response = await http.get(Uri.parse(url));
    debugPrint(response.body);
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
    debugPrint(response.body);
    Map cuisineData = json.decode(response.body);
    List<String> fetchedCuisineTypes = ['All']; // Default 'All' option
    // Assuming the API returns a list of cuisine types
    for (var cuisine in cuisineData['cuisineTypes']) {
      fetchedCuisineTypes
          .add(cuisine['name']); // Adjust according to your API response
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
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              restaurantsData?[index]['avatar'],
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
                                width: MediaQuery.of(context).size.width - 120,
                                child: Text(
                                  "${restaurantsData?[index]["name"]}",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w700),
                                  overflow:
                                      TextOverflow.ellipsis, // Handle overflow
                                  maxLines:
                                      1, // Ensure it doesn't take more than one line
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${restaurantsData?[index]["cuisineType"]}",
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ],
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

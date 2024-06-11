import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plantbazar/model/product_model.dart';
import 'package:plantbazar/shared/core/constants.dart';
import 'package:plantbazar/view/home/screens/home/home_grid.dart';
import 'package:plantbazar/view/search/widget/search_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchValue = '';
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection('Products');
  List<ProductClass> productList = [];
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 115,
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextFormField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(
                            () {
                              searchValue = value;
                            },
                          );
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              setState(
                                () {
                                  searchController.clear();
                                  searchValue = '';
                                },
                              );
                            },
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          border: InputBorder.none,
                          labelText: "Search",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Row(
              //   children: [
              //     // TextButton(
              //     //   onPressed: () {
              //     //     // Navigator.of(context).push(
              //     //     //   MaterialPageRoute(
              //     //     //     builder: (context) => const FilterScreen(),
              //     //     //   ),
              //     //     // );
              //     //   },
              //     //   child: const Text('Filter: Lowest price to Highest'),
              //     // ),
              //   ],
              // ),
              kHeight30,
              searchValue.isEmpty
                  ? HomeScreenGrid(productCollection: productCollection)
                  : FutureBuilder<List<ProductClass>>(
                      future: fetchSearchResults(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<ProductClass>? searchResults = snapshot.data;

                          return searchResults != null &&
                                  searchResults.isNotEmpty
                              ? SearchCard(searchResults: searchResults)
                              : emptySearch();
                        }
                      })
            ],
          ),
        ),
      ),
    );
  }

  Future<List<ProductClass>> fetchSearchResults() async {
    try {
      var querySnapshot = await productCollection
          .where('searchName',
              isGreaterThanOrEqualTo: searchValue.trim().toLowerCase())
          .where('searchName',
              isLessThanOrEqualTo: searchValue.toLowerCase() + '\uf8ff')
          .get();

      return querySnapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return ProductClass.fromJson(data);
        },
      ).toList();
    } catch (e) {
      print("Error fetching search results: $e");
      return [];
    }
  }
}

emptySearch() {
  return const SizedBox(
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not found',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF9C9C9C),
            ),
          )
        ],
      ),
    ),
  );
}

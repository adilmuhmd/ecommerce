import 'dart:convert';
import 'package:ecommerceapp/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Electronics extends StatefulWidget {
  const Electronics({super.key});

  @override
  State<Electronics> createState() => _ElectronicsState();
}

class _ElectronicsState extends State<Electronics> {
  Future<List<MediaPosts>>? futurePosts;

  Future<List<MediaPosts>> fetchPosts() async {
    final response = await http.get(Uri.parse('https://fakestoreapi.com/products/category/electronics'));
    // Check response
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      List limitedResponse = jsonResponse.take(20).toList();
      return limitedResponse.map((post) => MediaPosts.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load API');
    }
  }

  void fetchAndSetPosts() {
    setState(() {
      futurePosts = fetchPosts();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchAndSetPosts();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              FutureBuilder<List<MediaPosts>>(
                future: futurePosts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Text('No data found');
                  } else {
                    return Expanded(
                      child: ListView.builder(

                        scrollDirection: Axis.vertical, // Horizontal scrolling
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final post = snapshot.data![index];
                          return Container(
                            width: 20,
                            color: Colors.white,
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: Text('Title:${post.title}\n',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                    ),
                                  ),

                                ),

                            Container(
                              height: 200,
                              width:double.infinity,
                              child: Image(image: NetworkImage('${post.image}')
                              )
                            ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text(
                                            // 'Price:${post.price}\n'
                                            // 'TITLE:${post.category}\n'
                                            'RATING: ${post.rating['rate']} (${post.rating['count']} reviews)',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                    ),
                                    Container(
                                      child: FloatingActionButton(

                                        onPressed: () {
                                          setState(() {

                                          });
                                        },
                                        child: Text("Add to Cart",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),

                                        ),
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                      height: 40,
                                      width: 100,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.end,
                                ),

                                SizedBox(
                                  height: 50,
                                ),

                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class Ratehere {
//   final double rate;
//   final int count;
//
//   const Ratehere({
//     required this.rate,
//     required this.count
// });
//
//   factory Ratehere.fromJson(Map<String,dynamic> json){
//     return Ratehere(rate: json['rate'].toDouble(), count: json['count']);
//   }
//
// }
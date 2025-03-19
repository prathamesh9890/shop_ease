import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WishlistPage extends StatelessWidget {
  final List wishlistedProducts;

  WishlistPage({required this.wishlistedProducts});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Screen width le raha hai
    double screenHeight = MediaQuery.of(context).size.height; // Screen height le raha hai

    return Scaffold(
      appBar: AppBar(title: Text("Wishlist")),
      body: wishlistedProducts.isEmpty
          ? Center(child: Text("No items in Wishlist", style: TextStyle(fontSize: screenWidth * 0.05))) // Dynamic text size
          : ListView.builder(
        itemCount: wishlistedProducts.length,
        itemBuilder: (context, index) {
          var product = wishlistedProducts[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: 10), // Dynamic padding
            child: ListTile(
              leading: Image.network(product['image'], width: screenWidth * 0.15, height: screenWidth * 0.15), // Dynamic image size
              title: Text(product['title'], style: TextStyle(fontSize: screenWidth * 0.04)), // Dynamic text size
              subtitle: Text("\$${product['price']}", style: TextStyle(fontSize: screenWidth * 0.035)),
            ),
          );
        },
      ),
    );
  }
}

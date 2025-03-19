import 'package:flutter/material.dart';
import 'Cart.dart';

// Global Cart List
List<Map<String, dynamic>> cartItems = [];

class ProductDetailsPage extends StatelessWidget {
  final Map product;

  ProductDetailsPage({required this.product});

  void addToCart(BuildContext context) {
    bool isAlreadyInCart = cartItems.any((item) => item['id'] == product['id']);

    if (!isAlreadyInCart) {
      cartItems.add({
        "id": product['id'],
        "title": product['title'],
        "price": product['price'],
        "image": product['image'],
        "quantity": 1,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Added to Cart!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Already in Cart!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title'])),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'productImage${product['id']}',
                child: Center(
                  child: Image.network(
                    product['image'],
                    height: 250,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(product['title'], style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('\$${product['price']}', style: TextStyle(fontSize: 18, color: Colors.green)),
              SizedBox(height: 8),
              Text(product['description']),
              SizedBox(height: 16),

              // ✅ Buttons in Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Buttons ke beech space
                children: [
                  ElevatedButton(
                    onPressed: () {
                      addToCart(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text("Add to Cart"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text("Go to Cart"),
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

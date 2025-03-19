import 'package:flutter/material.dart';
import 'Checkout.dart';
import 'ProductDetailedScreen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decreaseQuantity(int index) {
    if (cartItems[index]['quantity'] > 1) {
      setState(() {
        cartItems[index]['quantity']--;
      });
    } else {
      removeFromCart(index);
    }
  }

  double getTotalPrice() {
    return cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: cartItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return Dismissible(
                  key: Key(item['id'].toString()), // Unique key for each item
                  direction: DismissDirection.endToStart, // Swipe from right to left
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.delete, color: Colors.white, size: 30),
                  ),
                  onDismissed: (direction) {
                    removeFromCart(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item['title']} removed from cart")),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: Image.network(item['image'], width: 50),
                      title: Text(item['title']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("\$${item['price']}"),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove_circle, color: Colors.red),
                                onPressed: () => decreaseQuantity(index),
                              ),
                              Text("${item['quantity']}", style: TextStyle(fontSize: 16)),
                              IconButton(
                                icon: Icon(Icons.add_circle, color: Colors.green),
                                onPressed: () => increaseQuantity(index),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeFromCart(index),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("Total: \$${getTotalPrice().toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => CheckoutPage(cartItems: cartItems),
                    ),);
                  },
                  child: Text("Proceed to Checkout"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


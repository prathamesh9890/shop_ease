import 'package:flutter/material.dart';
import 'Profile_page.dart';
import 'global.dart'; //

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CheckoutPage({required this.cartItems});

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();

  String name = "";
  String address = "";
  String phone = "";

  double getTotalPrice() {
    return widget.cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  void placeOrder() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      //  Order Data Add Karna
      Map<String, dynamic> newOrder = {
        "id": DateTime.now().millisecondsSinceEpoch, // Unique Order ID
        "items": List.from(widget.cartItems),
        "total": getTotalPrice(),
        "status": "Processing",
        "date": DateTime.now().toString(),
      };

      orderHistory.add(newOrder); //


      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Order placed successfully!")),
      );


      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => UserProfilePage()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Checkout")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Order Summary", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              Column(
                children: widget.cartItems.map((item) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: Image.network(item['image'], width: 50),
                      title: Text(item['title']),
                      subtitle: Text("Quantity: ${item['quantity']}"),
                      trailing: Text("\$${(item['price'] * item['quantity']).toStringAsFixed(2)}"),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 20),
              Text("Shipping Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: "Full Name"),
                      validator: (value) => value!.isEmpty ? "Enter your name" : null,
                      onSaved: (value) => name = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Address"),
                      validator: (value) => value!.isEmpty ? "Enter your address" : null,
                      onSaved: (value) => address = value!,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: "Phone Number"),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? "Enter phone number" : null,
                      onSaved: (value) => phone = value!,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Text(
                "Total: \$${getTotalPrice().toStringAsFixed(2)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: placeOrder,
                child: Text("Proceed to Payment"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

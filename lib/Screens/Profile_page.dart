import 'package:flutter/material.dart';
import 'global.dart'; // ✅ Order history list import karo

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ User Details Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/img.png'), // Dummy Profile Image
                  ),
                  SizedBox(height: 10),
                  Text("Prathamesh Rathod", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("rathodprathamesh23@gmail.com", style: TextStyle(color: Colors.grey)),
                  Text("+91 7757872473", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 10),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // TODO: Implement Edit Profile Functionality
                  //   },
                  //   child: Text("Edit Profile"),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            SizedBox(height: 10),

            //  Order History Section
            Text("Order History", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: orderHistory.isEmpty
                  ? Center(child: Text("No orders placed yet."))
                  : ListView.builder(
                itemCount: orderHistory.length,
                itemBuilder: (context, index) {
                  var order = orderHistory[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text("Order #${order['id']}"),
                      subtitle: Text(
                        "Total: \$${order['total'].toStringAsFixed(2)} | Status: ${order['status']}",
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // TODO: Navigate to Order Details Page
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

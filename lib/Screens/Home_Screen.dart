import 'package:flutter/material.dart';
import 'package:shop_ease/Screens/Cart.dart';
import 'package:shop_ease/Screens/product_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';


import 'Profile_page.dart';
class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Multi-Platform E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ResponsiveLayout(),
    );
  }
}

class ResponsiveLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return WebLayout();
        } else {
          return MobileLayout();
        }
      },
    );
  }
}

// Web Layout with Sidebar
class WebLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: NavigationSidebar(),
          ),
          Expanded(
            flex: 5,
            child: ProductGrid(),
          ),
        ],
      ),
    );
  }
}

// Mobile Layout with Bottom Navigation
class MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shop Ease"),backgroundColor: Colors.orangeAccent,centerTitle: true,
      // actions: [
      //   IconButton(onPressed: (){},  icon: Icon(Icons.favorite_border, color: Colors.black))
      // ],
      ),
      body: ProductGrid(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orangeAccent,
        currentIndex: 0, // Current selected index
        onTap: (index) {
          if (index == 1) { // Cart button click
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          } else if (index == 2) { // Profile button click
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserProfilePage()),
            );
          }
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),backgroundColor: Colors.green, label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),

    );
  }
}

// Sidebar for Web


class NavigationSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.orangeAccent,
      child: ListView(
        children: [
          // ✅ Profile Section with GestureDetector
          DrawerHeader(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/img.png'), // Dummy Profile Image
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserProfilePage()),
                    );
                  },
                  child: Column(
                    children: [

                      Text(
                        "Prathamesh Rathod",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "rathodprathamesh23@gmail.com",
                        style: TextStyle(color: Colors.white70),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Categories with ExpansionTile & Icons
          ExpansionTile(
            leading: Icon(Icons.category, color: Colors.black),
            title: Text("Categories", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
            children: [
              ListTile(
                leading: Icon(Icons.electrical_services, color: Colors.black),
                title: Text("Electronics", style: TextStyle(color: Colors.black)),
              ),
              ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.black),
                title: Text("Fashion", style: TextStyle(color: Colors.black)),
              ),
              ListTile(
                leading: Icon(Icons.kitchen, color: Colors.black),
                title: Text("Home & Kitchen", style: TextStyle(color: Colors.black)),
              ),
            ],
          ),

          ListTile(
            leading: Icon(Icons.shopping_cart, color: Colors.black),
            title: Text("Cart", style: TextStyle(color: Colors.black)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),


          // ListTile(
          //   leading: Icon(Icons.exit_to_app, color: Colors.black),
          //   title: Text("Logout", style: TextStyle(color: Colors.black)),
          //   onTap: () {
          //     // TODO: Add Logout Functionality
          //     print("Logout Clicked");
          //   },
          // ),
        ],
      ),
    );
  }
}


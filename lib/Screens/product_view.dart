import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'ProductDetailedScreen.dart';
import 'Wishlist.dart';

class ProductGrid extends StatefulWidget {
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  List products = [];
  List filteredProducts = [];
  Set<int> wishlist = {}; // Wishlist ke liye set
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
    searchController.addListener(() {
      filterProducts();
    });
  }

  Future<void> fetchProducts() async {
    try {
      var response = await Dio().get('https://fakestoreapi.com/products');
      setState(() {
        products = response.data;
        filteredProducts = products;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  void filterProducts() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products.where((product) {
        return product['title'].toLowerCase().contains(query);
      }).toList();
    });
  }

  void toggleWishlist(int productId) {
    setState(() {
      if (wishlist.contains(productId)) {
        wishlist.remove(productId);
      } else {
        wishlist.add(productId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search Products...",
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            // Wishlist Button
            IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                // Navigate to Wishlist Page
                List wishlistedProducts = products.where((product) => wishlist.contains(product['id'])).toList();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WishlistPage(wishlistedProducts: wishlistedProducts),
                  ),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: filteredProducts.isEmpty
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 800 ? 4 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              var product = filteredProducts[index];
              int productId = product['id'];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsPage(product: product),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: Hero(
                              tag: 'productImage$productId',
                              child: Image.network(
                                product['image'],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text('\$${product['price']}'),
                        ],
                      ),
                      Positioned(
                        top: 120,
                        right: 8,
                        child: IconButton(
                          icon: Icon(
                            wishlist.contains(productId) ? Icons.favorite : Icons.favorite_border,
                            color: wishlist.contains(productId) ? Colors.red : Colors.grey,
                          ),
                          onPressed: () {
                            toggleWishlist(productId);
                          },
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
    );
  }
}


import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Product {
  final String name;
  final double price;
  final String imageUrl;
  final String color;
  final String size;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.color,
    required this.size,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = [
    Product(
        name: 'Product 1',
        price: 10.0,
        imageUrl: 'assets/product1.jpg',
        color: 'Red',
        size: 'Small'),
    Product(
        name: 'Product 2',
        price: 20.0,
        imageUrl: 'assets/product2.jpg',
        color: 'Blue',
        size: 'Medium'),
    Product(
        name: 'Product 3',
        price: 15.0,
        imageUrl: 'assets/product3.jpg',
        color: 'Green',
        size: 'Large'),
  ];

  Map<Product, int> cartItems = {};

  int getTotalItems() {
    int totalItems = 0;
    cartItems.forEach((product, quantity) {
      totalItems += quantity;
    });
    return totalItems;
  }

  double getTotalPrice() {
    double totalPrice = 0.0;
    cartItems.forEach((product, quantity) {
      totalPrice += product.price * quantity;
    });
    return totalPrice;
  }

  void addItem(Product product) {
    setState(() {
      if (cartItems.containsKey(product)) {
        cartItems[product] = cartItems[product]! + 1;
        if (cartItems[product] == 5) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Alert'),
                content: Text(
                    'You have added 5 ${product.name} to your bag!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        cartItems[product] = 1;
      }
    });
  }

  void removeItem(Product product) {
    setState(() {
      if (cartItems.containsKey(product)) {
        if (cartItems[product]! > 0) {
          cartItems[product] = cartItems[product]! - 1;
        }
      }
    });
  }

  void checkout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Your order has been placed.'),
              SizedBox(height: 10),
              Text('Total Quantity: ${getTotalItems()}'),
              Text('Total Price: \$${getTotalPrice().toStringAsFixed(2)}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // Change text color to red
              ),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Shopping Cart'),
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {},
                ),
                if (getTotalItems() > 0)
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        getTotalItems().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent, // Set the background color of the app bar
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Bag',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Image.asset(
                      product.imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name),
                        Text(
                          'Color: ${product.color}, Size: ${product.size}',
                          style: TextStyle(fontSize: 12.0, color: Colors.grey),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () => removeItem(product),
                            ),
                            Text(
                              '${cartItems.containsKey(product) ? cartItems[product] : 0}',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () => addItem(product),
                            ),
                          ],
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${getTotalPrice().toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: checkout,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                backgroundColor: Colors.red,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 5.0),
                    Text(
                      'CHECK OUT',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

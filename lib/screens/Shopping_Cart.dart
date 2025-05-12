import 'package:flutter/material.dart';
import 'cart_screen.dart';

class ShoppingCartPage extends StatefulWidget {
  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Map<String, dynamic>> cartItems = [];

  void updateQuantity(int index, int change) {
    setState(() {
      cartItems[index]['quantity'] += change;
      if (cartItems[index]['quantity'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalItems = cartItems.fold(
      0,
      (sum, item) => sum + (item['quantity'] as int),
    );

    return Scaffold(
      appBar: AppBar(title: Text('Carrito ($totalItems items)')),
      body: CartScreen(
        initialCartItems: cartItems,
        onUpdateQuantity: updateQuantity,
        onRemoveItem: removeItem,
      ),
    );
  }
}

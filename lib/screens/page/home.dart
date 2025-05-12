import 'dart:convert';
import 'package:app_proyecto/screens/page/add_cart.dart';
import 'package:app_proyecto/screens/produc_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_proyecto/main.dart';
import 'package:app_proyecto/screens/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List list = [];
  List list2 = [];
  List<Map<String, dynamic>> cart = [];

  // Obtener todos los productos
  getAllItems() async {
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/"));
    if (res.statusCode == 200) {
      setState(() {
        list = jsonDecode(res.body);
      });
    } else {
      print('Error al obtener productos: ${res.statusCode}');
    }
  }

  // Obtener las categorías
  getAllCategory() async {
    var res = await http.get(
      Uri.parse("https://fakestoreapi.com/products/categories"),
    );
    if (res.statusCode == 200) {
      setState(() {
        list2 = jsonDecode(res.body);
      });
    } else {
      print('Error al obtener categorías: ${res.statusCode}');
    }
  }

  // Agregar producto al carrito
  void addToCart(Map<String, dynamic> product) {
    setState(() {
      bool exists = cart.any((item) => item['id'] == product['id']);
      if (!exists) {
        cart.add({...product, 'quantity': 1});
        saveCartToPrefs();
      }
    });
  }

  // Eliminar producto del carrito
  void removeFromCart(int index) {
    setState(() {
      cart.removeAt(index);
    });
  }

  // Actualizar cantidad del producto
  void updateQuantity(int index, int delta) {
    setState(() {
      cart[index]['quantity'] += delta;
      if (cart[index]['quantity'] <= 0) {
        cart.removeAt(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAllItems();
    getAllCategory();
    loadCartFromPrefs();
  }

  // Guardar carrito en SharedPreferences
  void saveCartToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cart);
    await prefs.setString('cart', cartJson);
  }

  // Cargar carrito al iniciar
  void loadCartFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cart');
    if (cartJson != null) {
      setState(() {
        cart = List<Map<String, dynamic>>.from(jsonDecode(cartJson));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Inicio"),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categorías",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  list2.map((e) {
                    return GestureDetector(
                      onTap: () async {
                        var res = await http.get(
                          Uri.parse(
                            "https://fakestoreapi.com/products/category/$e",
                          ),
                        );
                        if (res.statusCode == 200) {
                          setState(() {
                            list = jsonDecode(res.body);
                          });
                        }
                      },
                      child: Chip(label: Text(e.toString())),
                    );
                  }).toList(),
            ),
            SizedBox(height: 10),
            Text(
              "Todos los productos",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.8,
              ),
              itemBuilder: (context, index) {
                final product = list[index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              product['image'],
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['title'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "\$${product['price']}",
                              style: TextStyle(fontSize: 16),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove_red_eye),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (_) => ProductDetailScreen(
                                                  product: product,
                                                  onUpdate: (updated) {
                                                    setState(() {
                                                      list[index] = updated;
                                                    });
                                                  },
                                                  onDelete: () {
                                                    setState(() {
                                                      list.removeAt(index);
                                                    });
                                                  },
                                                ),
                                          ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.add_shopping_cart),
                                      onPressed: () {
                                        addToCart(product);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),

      //boton flotante de carrito
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'cart',
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => CartScreen(
                        cartItems: cart,
                        onRemoveItem: removeFromCart,
                        onUpdateQuantity: updateQuantity,
                        initialCartItems: cart,
                      ),
                ),
              );
              setState(() {});
            },
            backgroundColor: Colors.white,
            child: const Icon(Icons.shopping_cart),
          ),
          const SizedBox(height: 16),

          //boton flotante de crear producto
          FloatingActionButton(
            onPressed: () async {
              final newProduct = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProductScreen()),
              );

              if (newProduct != null) {
                setState(() {
                  list.add(newProduct);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Producto añadido con éxito")),
                );
              }
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

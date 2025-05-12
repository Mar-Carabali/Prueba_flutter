import 'dart:math';
import 'package:app_proyecto/screens/page/home.dart';
import 'package:flutter/material.dart';

class InvoiceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final double total;

  InvoiceScreen({required this.cartItems, required this.total});

  final String invoiceCode = "INV-${Random().nextInt(1000000)}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Factura")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Factura: $invoiceCode", style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(item['image'], width: 40),
                      title: Text(
                        item['title'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text("Cantidad: ${item['quantity']}"),
                      trailing: Text(
                        "\$${(item['quantity'] * item['price']).toStringAsFixed(2)}",
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Total: \$${total.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('¡Pagado con éxito!'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );

                  Future.delayed(const Duration(seconds: 2), () {
                    cartItems.clear(); // 🔥 Limpia el carrito

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  });
                },
                child: const Text("Pagar ahora"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

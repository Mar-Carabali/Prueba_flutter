import 'dart:io';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  final Function(Map<String, dynamic>) onUpdate;
  final VoidCallback onDelete;

  const ProductDetailScreen({
    Key? key,
    required this.product,
    required this.onUpdate,
    required this.onDelete,
  }) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.product['title']);
    descController = TextEditingController(text: widget.product['description']);
    priceController = TextEditingController(
      text: widget.product['price'].toString(),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final image = product['image'];

    return Scaffold(
      appBar: AppBar(title: Text("Detalle del producto")),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            height: 180,
            width: 180,
            child: Image(
              fit: BoxFit.contain,
              image:
                  image.toString().startsWith("http")
                      ? NetworkImage(image)
                      : FileImage(File(image)) as ImageProvider,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: "Título"),
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(labelText: "Descripción"),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: "Precio"),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        final updated = {
                          ...product,
                          'title': titleController.text,
                          'description': descController.text,
                          'price':
                              double.tryParse(priceController.text) ??
                              product['price'],
                        };
                        widget.onUpdate(updated);
                        Navigator.pop(context);
                      },
                      child: Text("Guardar"),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        widget.onDelete();
                        Navigator.pop(context);
                      },
                      child: Text("Eliminar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

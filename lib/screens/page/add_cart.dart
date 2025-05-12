import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  void _submitProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'title': _titleController.text,
        'description': _descController.text,
        'price': double.parse(_priceController.text),
        'image': _imageController.text,
      };

      Navigator.pop(context, newProduct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir producto")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Título"),
                validator:
                    (value) => value!.isEmpty ? 'Introduce un título' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: "Descripción"),
                validator:
                    (value) =>
                        value!.isEmpty ? 'Introduce una descripción' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Precio"),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Precio requerido';
                  if (double.tryParse(value) == null) return 'Precio inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: "URL de imagen"),
                validator:
                    (value) =>
                        value!.isEmpty
                            ? 'Introduce la URL de una imagen'
                            : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProduct,
                child: const Text("Guardar producto"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

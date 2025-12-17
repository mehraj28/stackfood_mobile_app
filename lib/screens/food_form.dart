import 'package:flutter/material.dart';

class FoodForm extends StatefulWidget {
  final Map<String, dynamic>? food;
  final Function(Map<String, dynamic>) onSubmit;

  const FoodForm({super.key, this.food, required this.onSubmit});

  @override
  State<FoodForm> createState() => _FoodFormState();
}

class _FoodFormState extends State<FoodForm> {
  final nameCtrl = TextEditingController();
  final priceCtrl = TextEditingController();
  final imageCtrl = TextEditingController();
  final descCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.food != null) {
      nameCtrl.text = widget.food!["name"];
      priceCtrl.text = widget.food!["price"].toString();
      imageCtrl.text = widget.food!["image_url"] ?? "";
      descCtrl.text = widget.food!["description"] ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.food == null ? "Add Food" : "Edit Food"),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
                controller: nameCtrl,
                decoration: const InputDecoration(labelText: "Name")),
            TextField(
                controller: priceCtrl,
                decoration: const InputDecoration(labelText: "Price")),
            TextField(
                controller: imageCtrl,
                decoration: const InputDecoration(labelText: "Image URL")),
            TextField(
                controller: descCtrl,
                decoration: const InputDecoration(labelText: "Description")),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel")),
        ElevatedButton(
          onPressed: () {
            widget.onSubmit({
              "name": nameCtrl.text,
              "price": double.parse(priceCtrl.text),
              "image_url": imageCtrl.text,
              "description": descCtrl.text,
            });
            Navigator.pop(context);
          },
          child: const Text("Save"),
        ),
      ],
    );
  }
}

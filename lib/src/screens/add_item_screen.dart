import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sme/src/providers/expenses.dart';
import 'package:sme/src/providers/purchases.dart';
import 'package:sme/src/providers/sales.dart';
import 'package:sme/src/widgets/hex_color.dart';

class AddItemScreen extends ConsumerStatefulWidget {
  final String title;
  final String type;
  const AddItemScreen({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _quantityController =
      TextEditingController(text: "0");
  final TextEditingController _priceController =
      TextEditingController(text: "0");
  final TextEditingController _costController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final sale = ref.watch(salesProvider);
    final purchase = ref.watch(purchasesProvider);
    final expense = ref.watch(expensesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Product name"),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _productController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Quantinty"),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _quantityController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {});
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Price"),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _priceController,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() {});
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text("Cost"),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _costController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: (int.parse(_quantityController.text, radix: 10) *
                          int.parse(_priceController.text, radix: 10))
                      .toString(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MaterialButton(
                onPressed: () async {
                  if (widget.type == "sales") {
                    final response = await sale.addSale(
                      _productController.text,
                      double.parse(_quantityController.text),
                      double.parse(_priceController.text),
                    );
                    if (response) {
                      ref.invalidate(salesProvider);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  } else if (widget.type == "purchases") {
                    final response = await purchase.addPurchase(
                      _productController.text,
                      double.parse(_quantityController.text),
                      double.parse(_priceController.text),
                    );
                    if (response) {
                      ref.invalidate(purchasesProvider);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  } else {
                    final response = await expense.addExpense(
                      _productController.text,
                      double.parse(_quantityController.text),
                      double.parse(_priceController.text),
                    );
                    if (response) {
                      ref.invalidate(expensesProvider);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  }
                },
                height: 56,
                color: HexColor("#102d61"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                minWidth: size.width,
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

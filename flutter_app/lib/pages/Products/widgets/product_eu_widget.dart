import 'package:flutter/material.dart';
import 'package:flutter_app/models/cart.dart';
import 'package:flutter_app/models/products_model.dart';
import 'package:flutter_app/services/product_service.dart';
import 'package:flutter_app/services/service_locator.dart';
import 'package:flutter_app/widgets/add_remove_button.dart';
import 'package:intl/intl.dart';

class ProductEUItem extends StatefulWidget {
  final ProductEUModel product;

  const ProductEUItem({super.key, required this.product});

  @override
  State<ProductEUItem> createState() => _ProductEUItemState();
}

class _ProductEUItemState extends State<ProductEUItem> {
  bool isOnCart = false;
  CartModel? prodToDelete;
  final productsService = getIt<ProductService>();

  @override
  void initState() {
    _checkCart();
    super.initState();
  }

  void _checkCart() async {
    var prod =
        await productsService.getProductFromCart(widget.product.id, "eu");
    if (prod != null) {
      if (prod.name.isNotEmpty) {
        setState(() {
          prodToDelete = prod;
          isOnCart = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    final precoFormatado = formatter.format(double.parse(widget.product.price));
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(widget.product.imagem,
                  height: 75, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.product.description,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDetail("Categoria", widget.product.details.adjective),
                _buildDetail("Material", widget.product.details.material),
                _buildDetail("Origem", "Europa"),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              precoFormatado,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            addRemoveCart(context, isOnCart, prodToDelete, productsService,
                widget.product, "eu"),
            SizedBox(height: 9),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
              },
              label: const Text("Fechar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Theme.of(context).primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}

Widget _buildDetail(String title, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(value),
    ],
  );
}

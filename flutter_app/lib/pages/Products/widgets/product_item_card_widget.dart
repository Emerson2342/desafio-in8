import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/string_formatter.dart';
import 'package:flutter_app/models/page.dart';
import 'package:flutter_app/pages/Products/widgets/product_br_widget.dart';
import 'package:flutter_app/pages/Products/widgets/product_eu_widget.dart';
import 'package:flutter_app/services/product_service.dart';
import 'package:flutter_app/services/service_locator.dart';

class ProductItemCardWidget extends StatefulWidget {
  const ProductItemCardWidget({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductItemCardWidget> createState() => _ProductItemCardWidgetState();
}

class _ProductItemCardWidgetState extends State<ProductItemCardWidget> {
  final productsService = getIt<ProductService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      // margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(widget.product.name,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    widget.product.image,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.broken_image,
                      size: 100,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Categoria: ${widget.product.category}",
                      style: const TextStyle(color: Colors.blueGrey)),
                  Text("Material: ${widget.product.material}",
                      style: const TextStyle(color: Colors.blueGrey)),
                  const SizedBox(height: 4),
                  Text(
                    priceBr(double.parse(widget.product.price)),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () =>
                          _showProductBottomSheet(context, widget.product),
                      child: const Text('Ver mais'),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }

  void _showProductBottomSheet(
      BuildContext context, ProductModel productIndex) async {
    if (productIndex.origin == 'br') {
      final product = await productsService.getProductBRById(productIndex.id);
      if (!context.mounted) {
        return;
      }
      showModalBottomSheet(
          context: context,
          builder: (_) => ProductBrBottomSheetWidget(product: product));
    } else {
      final product = await productsService.getProductEUById(productIndex.id);
      if (!context.mounted) {
        return;
      }
      showModalBottomSheet(
          context: context, builder: (_) => ProductEUItem(product: product));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/models/page.dart';

class ProductItemCardWidget extends StatelessWidget {
  const ProductItemCardWidget({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      // margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(product.name,
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
                    "https://picsum.photos/120/120?random=${product.id}",
                    width: 100,
                    height: 100,
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
                  Text("Categoria: ${product.category}",
                      style: const TextStyle(color: Colors.blueGrey)),
                  Text("Material: ${product.material}",
                      style: const TextStyle(color: Colors.blueGrey)),
                  const SizedBox(height: 4),
                  Text(product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14)),
                  const SizedBox(height: 8),
                  Text("R\$ ${product.price}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary))
                ],
              ))
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/string_formatter.dart';
import 'package:flutter_app/models/cart.dart';

class OrderItemsBottomSheet extends StatelessWidget {
  final OrderModel order;

  const OrderItemsBottomSheet({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Itens do Pedido',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];
                return ListTile(
                  leading: Image.network(
                    item.img,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.broken_image,
                          size: 50, color: Colors.grey);
                    },
                  ),
                  title: Text(item.name),
                  subtitle: Text(
                      'Quantidade: ${item.quantity} x ${priceBr(item.price)}'),
                  trailing: Text(priceBr(item.price * item.quantity)),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

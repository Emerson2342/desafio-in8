import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/message_helper.dart';
import 'package:flutter_app/helpers/string_formatter.dart';
import 'package:flutter_app/models/cart.dart';
import 'package:flutter_app/services/product_service.dart';
import 'package:flutter_app/services/service_locator.dart';

class CartItemCard extends StatefulWidget {
  final CartModel cartItem;
  final bool selected;
  final ValueChanged<bool?> onChanged;
  final VoidCallback updateList;

  const CartItemCard(
      {super.key,
      required this.cartItem,
      required this.selected,
      required this.onChanged,
      required this.updateList});

  @override
  State<CartItemCard> createState() => _CartItemCardState();
}

class _CartItemCardState extends State<CartItemCard> {
  final productsService = getIt<ProductService>();
  bool isEditing = false;
  late int newQuantity;

  @override
  void initState() {
    super.initState();
    newQuantity = widget.cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                  widget.cartItem.img,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 64),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.cartItem.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('Unidade: ${priceBr(widget.cartItem.price)}'),
                      Text(
                          'Total: ${priceBr(widget.cartItem.price * newQuantity)}'),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_up),
                      onPressed: isEditing
                          ? () {
                              if (newQuantity >= 1) {
                                setState(() => newQuantity++);
                              }
                            }
                          : null,
                    ),
                    Text(newQuantity.toString(),
                        style: const TextStyle(fontSize: 16)),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: isEditing && newQuantity > 1
                          ? () => setState(() => newQuantity--)
                          : null,
                    ),
                  ],
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text("Comprar"),
                      Checkbox(
                        value: widget.selected,
                        onChanged: widget.onChanged,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isEditing = !isEditing;
                      });
                      if (!isEditing &&
                          newQuantity != widget.cartItem.quantity) {
                        try {
                          await productsService.updateCart(
                              widget.cartItem.id!, newQuantity);
                          if (!context.mounted) {
                            return;
                          }
                          widget.updateList();
                          showMessage(context, "Produto Atualizado");
                        } catch (e) {
                          showMessage(context, "Erro ao atualizar produto");
                        }
                      }
                    },
                    child: Text(isEditing ? 'Atualizar' : 'Alterar Quantidade'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

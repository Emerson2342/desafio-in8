import 'package:flutter_app/helpers/string_formatter.dart';

class CartModel {
  final String? id;
  final String productId;
  final String name;
  final double price;
  final int quantity;
  final String img;
  final String origin;

  CartModel({
    this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.img,
    required this.origin,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'] ?? "0",
      productId: json['productId'] ?? "0",
      name: json['name'] ?? "",
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] ?? 1,
      img: json['img'] ?? "",
      origin: json['origin'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'img': img,
      'origin': origin,
    };
  }

  @override
  String toString() {
    return 'FiltroModel(nome: $name, preço: $price, quantidade: $quantity, origem: $origin)';
  }
}

class OrderModel {
  final List<CartModel> items;
  final int quantity;
  final double total;
  final DateTime createdAt;
  final String name;
  final String email;

  OrderModel({
    required this.items,
    required this.quantity,
    required this.total,
    required this.createdAt,
    required this.name,
    required this.email,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      items: (json['items'] as List<dynamic>)
          .map((item) => CartModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
      createdAt: DateTime.parse(json['createdAt'] as String),
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((item) => item.toJson()).toList(),
      'quantity': quantity,
      'total': total,
      'createdAt': createdAt.toIso8601String(),
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() {
    return "quantidade: $quantity\nPreço Total: ${priceBr(total)}\nCriado: $createdAt\nNome: $name\nEmail: $email";
  }
}

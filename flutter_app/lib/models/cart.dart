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
}

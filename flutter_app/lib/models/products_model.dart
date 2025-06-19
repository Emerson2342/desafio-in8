abstract class IProductModel {
  String get id;
  String get nome;
  String get preco;
  String get imagem;
}

class ProductEUModel implements IProductModel {
  final bool hasDiscount;
  final String name;
  final String description;
  final String price;
  final String discountValue;
  final DetailsModel details;
  @override
  final String id;
  @override
  final String imagem;
  @override
  String get nome => name;
  @override
  String get preco => price;

  ProductEUModel(
      {required this.hasDiscount,
      required this.name,
      required this.description,
      required this.price,
      required this.discountValue,
      required this.details,
      required this.id,
      required this.imagem});

  factory ProductEUModel.fromJson(Map<String, dynamic> json) {
    return ProductEUModel(
        hasDiscount: json['hasDiscount'] ?? false,
        name: json['name'] ?? "",
        description: json['description'] ?? "",
        price: json['price'] ?? "",
        discountValue: json['discountValue'] ?? "",
        details: DetailsModel.fromJson(json['details'] ?? []),
        id: json['id'] ?? "1",
        imagem: "https://picsum.photos/75/75?random=${json['id']}");
  }
}

class ProductBRModel implements IProductModel {
  @override
  final String id;
  @override
  final String nome;
  final String descricao;
  final String categoria;
  @override
  final String imagem;
  @override
  final String preco;
  final String material;
  final String departamento;

  ProductBRModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.categoria,
    required this.imagem,
    required this.preco,
    required this.material,
    required this.departamento,
  });

  factory ProductBRModel.fromJson(Map<String, dynamic> json) {
    return ProductBRModel(
      id: json['id'] ?? "",
      nome: json['nome'] ?? "",
      descricao: json['descricao'] ?? "",
      categoria: json['categoria'] ?? "",
      imagem: "https://picsum.photos/75/75?random=${json['id']}",
      preco: json['preco'] ?? "",
      material: json['material'] ?? "",
      departamento: json['departamento'] ?? "",
    );
  }
}

class DetailsModel {
  final String adjective;
  final String material;

  DetailsModel({
    required this.adjective,
    required this.material,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      adjective: json['adjective'],
      material: json['material'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adjective': adjective,
      'material': material,
    };
  }
}

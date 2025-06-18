class ProductEUModel {
  final bool hasDiscount;
  final String name;
  final String description;
  final String price;
  final String discountValue;
  final DetailsModel details;

  ProductEUModel(
      {required this.hasDiscount,
      required this.name,
      required this.description,
      required this.price,
      required this.discountValue,
      required this.details});

  factory ProductEUModel.fromJson(Map<String, dynamic> json) {
    return ProductEUModel(
      hasDiscount: json['hasDiscount'] ?? false,
      name: json['name'] ?? "",
      description: json['description'] ?? "",
      price: json['price'] ?? "",
      discountValue: json['discountValue'] ?? "",
      details: DetailsModel.fromJson(
        json['details'] ?? [],
      ),
    );
  }
}

class ProductBRModel {
  final String id;
  final String nome;
  final String descricao;
  final String categoria;
  final String imagem;
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
      imagem: json['imagem'] ?? "",
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

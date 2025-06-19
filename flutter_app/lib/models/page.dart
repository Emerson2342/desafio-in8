class PageModel {
  final int page;
  final int totalPages;
  final int limit;
  final int total;
  final List<ProductModel> data;

  PageModel(
      {required this.page,
      required this.totalPages,
      required this.limit,
      required this.total,
      required this.data});

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      page: json['page'],
      totalPages: json['totalPages'],
      limit: json['limit'],
      total: json['total'],
      data: ((json['data'] ?? []) as List)
          .map((d) => ProductModel.fromJson(d))
          .toList(),
    );
  }
}

class ProductModel {
  final String id;
  final String name;
  final String category;
  final String material;
  final String description;
  final String image;
  final String price;
  final String origin;

  ProductModel(
      {required this.id,
      required this.name,
      required this.category,
      required this.material,
      required this.description,
      required this.image,
      required this.price,
      required this.origin});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      material: json['material'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      origin: json['origin'],
    );
  }
}

class FiltersModel {
  final List<String> categories;
  final List<String> materials;

  FiltersModel({required this.categories, required this.materials});

  factory FiltersModel.fromJson(Map<String, dynamic> json) {
    return FiltersModel(
        categories: List<String>.from(json['categories'] ?? []),
        materials: List<String>.from(json['materials'] ?? []));
  }
}

class FiltroModel {
  final String? categoria;
  final String? material;
  final String? min;
  final String? max;
  final String? orderBy;

  FiltroModel({
    this.categoria,
    this.material,
    this.min,
    this.max,
    this.orderBy,
  });

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};

    if (min != null) params['minPrice'] = min;
    if (max != null) params['maxPrice'] = max;
    if (material?.isNotEmpty == true) params['material'] = material;
    if (categoria?.isNotEmpty == true) params['category'] = categoria;
    if (orderBy?.isNotEmpty == true) params['orderBy'] = orderBy;

    return params;
  }

  @override
  String toString() {
    return 'FiltroModel(categoria: $categoria, material: $material, min: $min, max: $max, orderBy: $orderBy)';
  }
}

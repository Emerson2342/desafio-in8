import 'package:dio/dio.dart';
import 'package:flutter_app/models/page.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:3000/"));

  Future<PageModel> getProducts({
    int page = 1,
    double? min,
    double? max,
    String? material,
    String? tipo,
  }) async {
    final queryParams = {
      'page': page,
      'limit': 12,
      if (min != null) 'min': min,
      if (max != null) 'max': max,
      if (material != null && material.isNotEmpty) 'material': material,
      if (tipo != null && tipo.isNotEmpty) 'tipo': tipo,
    };
    try {
      final response = await _dio.get(
        'products',
        queryParameters: queryParams,
      );
      return PageModel.fromJson(response.data);
    } catch (e) {
      print('Erro ao buscar produtos: $e');

      rethrow;
    }
  }
}

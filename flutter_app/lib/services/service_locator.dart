import 'package:flutter_app/services/product_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<ProductService>(() => ProductService());
}

import 'dart:async';

import '../../../models/produtct_model.dart';

abstract class IProductRepository {
  FutureOr<bool> deleteProduct(int? id);
  FutureOr<ProductModel> getProduct(int? id);
  FutureOr<List<ProductModel>> getProducts();
  FutureOr<bool> insertProduct(ProductModel product);
  FutureOr<ProductModel> updateProduct(ProductModel product);
}

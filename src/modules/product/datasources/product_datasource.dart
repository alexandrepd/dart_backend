import '../../../models/produtct_model.dart';

abstract class IProductDatasource {
  Future<bool> insertProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<bool> deleteProduct(int? id);
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProduct(int? id);
}

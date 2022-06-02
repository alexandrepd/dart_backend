import 'dart:async';
import '../../../models/produtct_model.dart';
import '../datasources/product_datasource.dart';
import 'product_repository.dart';

class ProductRepositoryImplemention implements IProductRepository {
  ProductRepositoryImplemention(this._datasource);
  final IProductDatasource _datasource;

  @override
  Future<bool> deleteProduct(int? id) async {
    final bool deletedProduct = await _datasource.deleteProduct(id);
    return deletedProduct;
  }

  @override
  FutureOr<ProductModel> getProduct(int? id) async {
    final ProductModel entity = await _datasource.getProduct(id);
    return entity;
  }

  @override
  FutureOr<List<ProductModel>> getProducts() async {
    List<ProductModel> listEntity = await _datasource.getProducts();
    return listEntity;
  }

  @override
  FutureOr<bool> insertProduct(ProductModel product) async {
    final bool insertedProduct = await _datasource.insertProduct(product);
    return insertedProduct;
  }

  @override
  FutureOr<ProductModel> updateProduct(ProductModel product) async {
    final ProductModel updatedProduct =
        await _datasource.updateProduct(product);
    return updatedProduct;
  }
}

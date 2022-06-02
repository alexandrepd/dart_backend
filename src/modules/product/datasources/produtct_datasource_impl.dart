import 'dart:async';
import 'dart:io' show File;
import 'dart:convert';
import '../../../core/exceptions/item_not_found_exception.dart';
import '../../../models/produtct_model.dart';
import 'product_datasource.dart';

class ProductDataSource implements IProductDatasource {
  final File _file = File('src/core/json_database_mock/products.json');
  static List<ProductModel> listProductModel = [];

  ProductDataSource() {
    _init();
  }

  void _init() {
    final x = jsonDecode(_file.readAsStringSync());

    for (var element in x['data']) {
      listProductModel.add(
        ProductModel.fromMap(element),
      );
    }
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    return listProductModel;
  }

  @override
  Future<ProductModel> getProduct(int? id) async {
    ProductModel productModel = listProductModel.firstWhere(
      (element) => element.id == id,
      orElse: () => ProductModel(id: 0000),
    );

    if (productModel.id == 0000) {
      throw ItemNotFoundException("ProductDataSource -> getProduct>");
    }

    return productModel;
  }

  @override
  Future<bool> deleteProduct(int? id) async {
    int beforeLenght = listProductModel.length;
    listProductModel.removeWhere((element) => element.id == id);
    int afterlenght = listProductModel.length;
    if (beforeLenght == afterlenght) {
      throw ItemNotFoundException("ProductDataSource -> deleteProduct>");
    }

    return beforeLenght > afterlenght;
  }

  @override
  Future<bool> insertProduct(ProductModel product) async {
    int beforeLenght = listProductModel.length;
    listProductModel.add(product);
    int afterlenght = listProductModel.length;

    return beforeLenght < afterlenght;
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    int? idProduct = listProductModel.indexWhere(
      (element) => element.id == product.id,
    );
    if (idProduct == -1) {
      throw ItemNotFoundException("ProductDataSource -> updateProduct>");
    }
    listProductModel[idProduct] = product;

    return listProductModel[idProduct];
  }
}

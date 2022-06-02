import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:shelf/shelf.dart';
import '../../../core/exceptions/item_not_found_exception.dart';
import '../../../models/produtct_model.dart';
import '../datasources/product_datasource.dart';
import '../repositories/product_repository.dart';
import '../repositories/products_repository_impl.dart';

class ProductService {
  ProductService(this._datasource) {
    _repository = ProductRepositoryImplemention(_datasource);
  }
  final IProductDatasource _datasource;
  late IProductRepository _repository;

  FutureOr<Response> insertProduct(Request request) async {
    String x = await request.readAsString();

    if (await _datasource.insertProduct(ProductModel.fromJson(x))) {
      return Response.ok('Inserido com sucesso');
    } else {
      return Response.internalServerError(body: "Não inserido");
    }
  }

  FutureOr<Response> updateProduct(Request request) async {
    String x = await request.readAsString();

    try {
      ProductModel newProduct =
          await _datasource.updateProduct(ProductModel.fromJson(x));

      return Response.ok(
        newProduct.toJson(),
      );
    } on ItemNotFoundException catch (e) {
      log(e.toString());
      return Response.notFound('Impossivel atualizar produto');
    } catch (e) {
      log(e.toString());
      return Response.internalServerError(body: 'Erro no servidor');
    }
  }

  FutureOr<Response> getProducts(Request request) async {
    try {
      List<ProductModel> list = await _datasource.getProducts();

      return Response.ok(
        jsonEncode(
            list.map((ProductModel element) => element.toJson()).toList()),
      );
    } on ItemNotFoundException catch (e) {
      log(e.toString());
      return Response.notFound('Impossivel encontrar produto');
    } catch (e) {
      print(e);
      return Response.internalServerError(body: 'Erro no servidor');
    }
  }

  FutureOr<Response> getProduct(Request request, String id) async {
    try {
      int? parseId = int.tryParse(id);

      ProductModel product = await _repository.getProduct(parseId);

      return Response.ok(
        product.toJson(),
      );
    } on ItemNotFoundException catch (e) {
      log(e.toString());
      return Response.notFound('Product not found');
    } catch (e) {
      print(e);
      return Response.internalServerError(body: 'Erro no servidor');
    }
  }

  FutureOr<Response> deleteProduct(Request request, String id) async {
    int? parseId = int.tryParse(id);

    try {
      final bool deleted = await _datasource.deleteProduct(parseId);
      if (deleted) {
        return Response.ok('Deletado com sucesso');
      }
      return Response.notFound('impossível deletar produto');
    } on ItemNotFoundException catch (e) {
      log(e.toString());
      return Response.notFound('Product not found');
    } catch (e) {
      return Response.internalServerError(body: "Erro no servidor");
    }
  }
}

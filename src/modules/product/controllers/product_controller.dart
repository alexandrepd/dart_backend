import 'package:shelf_router/shelf_router.dart';
import '../datasources/produtct_datasource_impl.dart';
import '../services/product_service.dart';

class ProductController {
  Router get router {
    final Router router = Router();

    ProductDataSource dataSource = ProductDataSource();
    ProductService service = ProductService(dataSource);

    router.get('/products', service.getProducts);
    router.get('/product/<id>', service.getProduct);
    router.delete('/product/<id>', service.deleteProduct);
    router.post('/product', service.insertProduct);
    router.put('/product', service.updateProduct);
    return router;
  }
}

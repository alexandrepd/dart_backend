import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import '../src/core/default_content_type/default_content_type.dart';
import '../src/modules/product/controllers/product_controller.dart';

void main(List<String> args) async {
  // Configure routes.
  final router = Router();

  router.mount('/api/', ProductController().router);
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(DefaultContentType().middleware)
      .addHandler(router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('🚀 Server listening on port ${server.port}');
}

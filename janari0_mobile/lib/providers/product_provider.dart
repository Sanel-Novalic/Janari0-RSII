import 'package:flutter/foundation.dart';

import '../model/product.dart';
import 'base_provider.dart';

class ProductProvider extends BaseProvider<Product> {
  ProductProvider() : super('baseUrl');
}

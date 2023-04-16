import '../model/product_sale.dart';
import 'base_provider.dart';

class ProductSaleProvider extends BaseProvider<ProductSale> {
  ProductSaleProvider() : super("ProductsSale");

  @override
  ProductSale fromJson(data) {
    return ProductSale.fromJson(data);
  }
}

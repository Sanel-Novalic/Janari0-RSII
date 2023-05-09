import './base_provider.dart';
import '../model/order.dart';

class OrderProvider extends BaseProvider<Order> {
  OrderProvider() : super("Orders");

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }
}

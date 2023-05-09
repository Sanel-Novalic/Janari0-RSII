import '../model/buyer.dart';
import 'base_provider.dart';

class BuyerProvider extends BaseProvider<Buyer> {
  BuyerProvider() : super("Buyers");

  @override
  Buyer fromJson(data) {
    return Buyer.fromJson(data);
  }
}

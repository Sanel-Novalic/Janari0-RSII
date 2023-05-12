import '../model/output.dart';
import './base_provider.dart';

class OutputProvider extends BaseProvider<Output> {
  OutputProvider() : super("Output");

  @override
  Output fromJson(data) {
    return Output.fromJson(data);
  }
}

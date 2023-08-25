import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class UploadFile {
  late bool success;
  late String message;

  late bool isUploaded;

  Future<void> call(String url, XFile? image) async {
    try {
      Uint8List bytes = await image!.readAsBytes();
      var response = await http.put(url as Uri, body: bytes);
      if (response.statusCode == 200) {
        isUploaded = true;
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}

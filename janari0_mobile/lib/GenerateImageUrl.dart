import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class GenerateImageUrl {
  late bool success;
  late String message;

  late bool isGenerated;
  late String uploadUrl;
  late String downloadUrl;

  Future<void> call(String fileType) async {
    try {
      Map body = {"fileType": fileType};
      print("YES");
      var response = await http.post(
        'http://${Platform.isIOS ? 'localhost' : '10.0.2.2'}:5000/generatePresignedUrl'
            as Uri,
        body: body,
      );

      var result = jsonDecode(response.body);
      print("YES");
      if (result['success'] != null) {
        success = result['success'];
        message = result['message'];

        if (response.statusCode == 201) {
          isGenerated = true;
          uploadUrl = result["uploadUrl"];
          downloadUrl = result["downloadUrl"];
        }
      }
    } catch (e) {
      throw ('Error getting url');
    }
  }
}

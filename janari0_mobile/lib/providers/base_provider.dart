import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:flutter/foundation.dart';
import 'package:janari0/model/product_sale.dart';

import '../model/order.dart';
import '../model/payment.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  String? _baseUrl;
  String? _endpoint;

  HttpClient client = HttpClient();
  IOClient? http;
  FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  BaseProvider(String endpoint) {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue:
            "http://10.0.2.2:7158/"); // When testing from your phone, put your usb debugging computer's ip address instead
    debugPrint("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }

    _endpoint = endpoint;
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
    firebaseToken();
  }

  void firebaseToken() async {
    bool isAdmin = _baseUrl?.contains('localhost') ?? false;
    if (isAdmin) {
      return;
    }
    String? token = await FirebaseAuth.instance.currentUser?.getIdToken();

    if (token != null) {
      await secureStorage.write(key: 'firebaseToken', value: token);
    }
  }

  Future<Map<String, String>> createHeaders() async {
    final token = await secureStorage.read(key: 'firebaseToken');

    var headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Authorization": "Bearer $token"
    };
    return headers;
  }

  Future<List<T>> get([dynamic search]) async {
    var url = "$_baseUrl$_endpoint";

    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    Map<String, String> headers = await createHeaders();
    try {
      var response = await http!
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 6));
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body) as List;
        return data.map((x) => fromJson(x)).cast<T>().toList();
      } else {
        throw Exception("Exception... handle this gracefully");
      }
    } catch (e) {
      debugPrint("Error");
      debugPrint(e.toString());
    }
    return List<T>.empty();
  }

  Future<T> getById(int id, [dynamic additionalData]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();

    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<T>> getCarouselData([dynamic search]) async {
    var url = "$_baseUrl$_endpoint/GetCarouselData";

    if (search != null) {
      String queryString = getQueryString(search);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();
    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => fromJson(x)).cast<T>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<T?> insert(dynamic request) async {
    var url = "$_baseUrl$_endpoint";
    var uri = Uri.parse(url);
    debugPrint(url);
    Map<String, String> headers = await createHeaders();
    var jsonRequest = jsonEncode(request);
    debugPrint(jsonRequest);
    try {
      var response = await http!
          .post(uri, headers: headers, body: jsonRequest)
          .timeout(const Duration(seconds: 4));
      if (isValidResponseCode(response)) {
        if (response.body == '') return null;
        var data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        return null;
      }
    } on TimeoutException {
      throw Exception("Something is invalid");
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();
    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      try {
        var data = jsonDecode(response.body);
        return fromJson(data);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      return null;
    }
    return null;
  }

  Future<T?> delete(int id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();

    var response = await http!.delete(uri, headers: headers);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  T fromJson(data) {
    throw Exception("Override method");
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  Future<List<T>?> getRecommended(int id) async {
    if (T == ProductSale) {
      var url = "$_baseUrl$_endpoint/$id/Recommend";

      var uri = Uri.parse(url);

      Map<String, String> headers = await createHeaders();
      var response = await http!.get(uri, headers: headers);

      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data.map((x) => fromJson(x)).cast<T>().toList();
      } else {
        throw Exception("Exception... handle this gracefully");
      }
    } else {
      return null;
    }
  }

  Future<T?> login(String email, String password) async {
    var url = "$_baseUrl$_endpoint/Login";

    var object = {"email": email, "password": password};
    String queryString = getQueryString(object);
    url = "$url?$queryString";
    var uri = Uri.parse(url);

    Map<String, String> headers = await createHeaders();
    var response = await http!.get(uri, headers: headers);

    await signInWithEmailPasswordAdmin(email, password);
    if (isValidResponseCode(response)) {
      if (response.body == '') {
        throw ("User login invalid or does not have permission to access");
      }
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw ("Something went wrong...");
    }
  }

  Future signInWithEmailPasswordAdmin(String email, String password) async {
    final Uri uri = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDD5K23WGLr9UIevPH5CQj5oKDAs2M5AVM');
    final response = await http?.post(uri,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));

    if (response?.statusCode == 200) {
      final responseBody = json.decode(response!.body);
      if (responseBody['idToken'] != null) {
        await secureStorage.write(
            key: 'firebaseToken', value: responseBody['idToken']);
      }
    } else {
      throw ("Couldn't login admin to firebase");
    }
  }

  bool isValidResponseCode(Response response) {
    if (response.statusCode == 200) {
      if (response.body != "") {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 400) {
      throw Exception("Bad request");
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized access!");
    } else if (response.statusCode == 403) {
      throw Exception("Forbidden");
    } else if (response.statusCode == 404) {
      throw Exception("Not found");
    } else if (response.statusCode == 500) {
      throw Exception("Internal server error");
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<T?> beginTransaction(dynamic payment) async {
    if (T == Payment) {
      var url = "$_baseUrl$_endpoint/BeginTransaction";
      var uri = Uri.parse(url);

      Map<String, String> headers = await createHeaders();

      var jsonRequest = jsonEncode(payment);
      var response = await http!.post(uri, headers: headers, body: jsonRequest);

      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return fromJson(data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<Order?> saveTransaction(int orderId) async {
    if (T == Payment) {
      var url = "$_baseUrl$_endpoint/SaveTransaction";
      var query = {'orderId': orderId};

      String queryString = getQueryString(query);
      url = "$url?$queryString";

      var uri = Uri.parse(url);

      Map<String, String> headers = await createHeaders();

      var response = await http!.post(uri, headers: headers);

      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        if (data == null) {
          return null;
        }
        return Order.fromJson(data);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}

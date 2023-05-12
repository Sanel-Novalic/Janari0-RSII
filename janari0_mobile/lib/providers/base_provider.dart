import 'dart:convert';
import 'dart:io';
import 'dart:async';
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

  BaseProvider(String endpoint) {
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7158/");
    debugPrint("baseurl: $_baseUrl");

    if (_baseUrl!.endsWith("/") == false) {
      _baseUrl = "${_baseUrl!}/";
    }

    _endpoint = endpoint;
    client.badCertificateCallback = (cert, host, port) => true;
    http = IOClient(client);
  }

  Map<String, String> createHeaders() {
    var headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*"
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

    Map<String, String> headers = createHeaders();
    print(uri);
    try {
      var response = await http!.get(uri, headers: headers);
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        return data.map((x) => fromJson(x)).cast<T>().toList();
      } else {
        throw Exception("Exception... handle this gracefully");
      }
    } catch (e) {
      print("Error");
      print(e.toString());
    }
    return List<T>.empty();
  }

  Future<T> getById(int id, [dynamic additionalData]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

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

    Map<String, String> headers = createHeaders();
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
    Map<String, String> headers = createHeaders();
    var jsonRequest = jsonEncode(request);
    debugPrint(jsonRequest);
    var response = await http!.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<T?> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

    var response =
        await http!.put(uri, headers: headers, body: jsonEncode(request));

    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      return null;
    }
  }

  Future<T?> delete(int id) async {
    var url = "$_baseUrl$_endpoint/$id";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();

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

      Map<String, String> headers = createHeaders();
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

  Future login(String username, String password) async {
    var url = "$_baseUrl$_endpoint/Login";

    var object = {"username": username, "password": password};
    String queryString = getQueryString(object);
    url = "$url?$queryString";
    print(url);
    var uri = Uri.parse(url);
    print(uri);
    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);

    if (isValidResponseCode(response)) {
      return;
    } else {
      throw Exception("Exception... handle this gracefully");
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
      throw Exception("Wrong username or password ! Please try again...");
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

      Map<String, String> headers = createHeaders();

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

      Map<String, String> headers = createHeaders();

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

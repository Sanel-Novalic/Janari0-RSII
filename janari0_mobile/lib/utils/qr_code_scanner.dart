import 'package:flutter/material.dart';
import 'package:openfoodfacts/model/ProductResultV3.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import '../screens/add_product_name_screen.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:janari0/model/user.dart' as u;

class QRCodeScanner {
  static Future<Product?> getProduct(String barcode) async {
    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      version: ProductQueryVersion.v3,
    );
    final ProductResultV3 result =
        await OpenFoodAPIClient.getProductV3(configuration);

    if (result.status == ProductResultV3.statusSuccess) {
      return result.product;
    } else {
      throw Exception('product not found, please insert data for $barcode');
    }
  }

  static startBarcodeScanner(context, u.User user) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    debugPrint(barcodeScanRes);
    if (barcodeScanRes == '-1') return;
    SmartDialog.showLoading();
    try {
      Product? product = await getProduct(barcodeScanRes);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddProductName(
                    name: product?.productName,
                    scannedImage: product?.imageFrontUrl,
                    user: user,
                  )));
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
    SmartDialog.dismiss();
    debugPrint("janari    $barcodeScanRes");
  }
}

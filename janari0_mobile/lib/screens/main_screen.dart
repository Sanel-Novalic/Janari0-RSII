import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:janari0_mobile/providers/location_provider.dart';
import 'package:janari0_mobile/providers/product_provider.dart';
import 'package:janari0_mobile/providers/product_sale_provider.dart';
import 'package:janari0_mobile/qr_code_scanner.dart';
import 'package:janari0_mobile/screens/profile_screen.dart';
import '../model/product.dart';
import '../model/product_sale.dart';
import '../model/requests/location_CU_request.dart';
import '../providers/user_provider.dart';
import '../utils/custom_popup_button.dart';
import '../utils/carousel.dart';
import '../utils/custom_outline_button.dart';
import 'package:janari0_mobile/model/user.dart' as u;
import 'package:location/location.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "/main";
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  List<Product> freshProducts = [];
  List<Product> nearlyExpiredProducts = [];
  List<Product> expiredProducts = [];
  List<Product> products = [];
  late List<ProductSale> productsSale;
  ProductProvider productProvider = ProductProvider();
  UserProvider userProvider = UserProvider();
  ProductSaleProvider productSaleProvider = ProductSaleProvider();
  u.User user = u.User();
  late Future<List<ProductSale>> myFuture;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    myFuture = loadData();
  }

  void getLocation(u.User user) async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();
    LocationProvider locationProvider = LocationProvider();
    var locationUpdateRequest = LocationCURequest(
        latitude: locationData.latitude!, longitude: locationData.longitude!);
    locationProvider.update(user.locationId, locationUpdateRequest);
    print("HALLE");
  }

  Future<List<ProductSale>> loadData() async {
    var searchRequest = {'uid': FirebaseAuth.instance.currentUser?.uid};
    var tmpData = await productProvider.get(searchRequest);
    for (var product in tmpData) {
      if (product.expirationDate!.compareTo(DateTime.now()) < 0) {
        expiredProducts.add(product);
      } else {
        freshProducts.add(product);
        if (product.expirationDate!
                .compareTo(DateTime.now().add(const Duration(days: 7))) <
            0) {
          nearlyExpiredProducts.add(product);
        }
      }
    }
    var tmpUser = await userProvider.get(searchRequest);
    user = tmpUser.first;
    var tmpSale = await productSaleProvider.get(null);

    setState(() {
      user = tmpUser.first;
      products = tmpData;
      productsSale = tmpSale;
    });
    getLocation(user);
    return productsSale;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Show QR Code Scanner',
            onPressed: () {
              QRCodeScanner.startBarcodeScanner(context, user);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Show search bar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.question_mark),
              tooltip: 'Show tutorial',
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person),
              tooltip: 'Show profile',
              onPressed: () async {
                //await FirebaseAuth.instance.signOut();
                //if (!mounted) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profile(
                              user: user,
                              products: products,
                            )));
              },
            ),
          ],
        ),
        floatingActionButton: Stack(
          children: [
            ExpandableSponsorFloatingButton(
              products: products,
              user: user,
            )
          ],
        ),
        body: FutureBuilder<List<ProductSale>>(
            future: myFuture,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              print("WHY");
              return Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.png'),
                        fit: BoxFit.cover,
                        opacity: 0.05)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: const Text("PRODUCTS"),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.center,
                        child: const Text("ABOUT TO EXPIRE"),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomOutlineButton(
                              text: 'Fresh',
                              number: freshProducts.length,
                              color: Colors.green,
                              products: freshProducts),
                          CustomOutlineButton(
                            text: 'Within one week',
                            number: nearlyExpiredProducts.length,
                            color: Colors.yellow,
                            products: nearlyExpiredProducts,
                          ),
                          CustomOutlineButton(
                            text: 'Expired',
                            number: expiredProducts.length,
                            color: Colors.red,
                            products: expiredProducts,
                          ),
                        ],
                      ),
                      const SizedBox(height: 85),
                      CustomCarousel(
                        text: "Nearby",
                        productsSale: productsSale,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      const Image(
                          image: NetworkImage(
                              "https://developers.google.com/static/admob/images/ios-testad-0-admob.png")),
                      CustomCarousel(
                        text: "Nearby",
                        productsSale: productsSale,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

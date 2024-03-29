import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:janari0/main.dart';
import 'package:janari0/providers/location_provider.dart';
import 'package:janari0/providers/product_provider.dart';
import 'package:janari0/providers/product_sale_provider.dart';
import 'package:janari0/screens/product_details_screen.dart';
import 'package:janari0/utils/qr_code_scanner.dart';
import 'package:janari0/screens/profile_screen.dart';
import 'package:janari0/utils/search_card.dart';
import 'package:search_page/search_page.dart';
import '../model/product.dart';
import '../model/product_sale.dart';
import '../model/requests/location_CU_request.dart';
import '../providers/user_provider.dart';
import '../utils/custom_popup_button.dart';
import '../utils/carousel.dart';
import '../utils/custom_outline_button.dart';
import 'package:janari0/model/user.dart' as u;
import 'package:location/location.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  List<Product> freshProducts = [];
  List<Product> nearlyExpiredProducts = [];
  List<Product> expiredProducts = [];
  List<Product> products = [];
  late List<ProductSale> nearbyProducts;
  late List<ProductSale> freeProducts;
  List<ProductSale> allProductsSale = [];
  List<ProductSale> recommendedProductsSale = [];
  ProductProvider productProvider = ProductProvider();
  UserProvider userProvider = UserProvider();
  ProductSaleProvider productSaleProvider = ProductSaleProvider();
  u.User user = u.User();
  Timer? _logoutTimer;
  final StreamController<List<ProductSale>> _dataController =
      StreamController<List<ProductSale>>();
  Stream<List<ProductSale>> get dataStream => _dataController.stream;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _dataController.addStream(loadData());
    });
  }

  Future<void> _refreshData() async {
    freshProducts = [];
    nearlyExpiredProducts = [];
    expiredProducts = [];
    await _dataController.addStream(loadData());
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully refreshed the page'),
    ));
  }

  Future getLocation(u.User user) async {
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
    await locationProvider.update(user.locationId!, locationUpdateRequest);

    var searchRequest = {
      'carousel': "Nearby",
      'latitude': locationData.latitude,
      'longitude': locationData.longitude
    };
    nearbyProducts = await productSaleProvider.getCarouselData(searchRequest);
    searchRequest = {
      'carousel': "Free",
      'latitude': locationData.latitude,
      'longitude': locationData.longitude
    };
    freeProducts = await productSaleProvider.getCarouselData(searchRequest);
  }

  Stream<List<ProductSale>> loadData() async* {
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
    allProductsSale = await productSaleProvider.get(null);
    await getLocation(user);
    recommendedProductsSale =
        (await productSaleProvider.getRecommended(user.userId))!;
    setState(() {
      user = tmpUser.first;
      products = tmpData;
    });
    if (nearbyProducts.isEmpty) nearbyProducts = List<ProductSale>.empty();
    yield nearbyProducts;
  }

  void startTimeout() {
    cancelLogoutTimeout();

    _logoutTimer = Timer(const Duration(seconds: 20), () async {
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong and couldn\'t load the page'),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MyHomePage()));
    });
  }

  void cancelLogoutTimeout() {
    _logoutTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    startTimeout();
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: StreamBuilder<List<ProductSale>>(
          stream: dataStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                      child: SpinKitCircle(
                    color: Colors.green,
                    size: 50.0,
                  )));
            } else {
              cancelLogoutTimeout();
            }
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
                          showSearch(
                              context: context,
                              delegate: SearchPage<ProductSale>(
                                items: allProductsSale,
                                searchLabel: 'Search products on sale',
                                suggestion: ListView.builder(
                                  itemCount: recommendedProductsSale.length,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (BuildContext context, int i) =>
                                      Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                        productSale:
                                                            recommendedProductsSale[
                                                                i],
                                                        user: user))),
                                        child: SearchCard(
                                            productSale:
                                                recommendedProductsSale[i])),
                                  ),
                                ),
                                failure: const Center(
                                  child: Text('No product found :('),
                                ),
                                filter: (product) => [
                                  product.product?.name,
                                ],
                                builder: (productSale) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                        productSale:
                                                            productSale,
                                                        user: user))),
                                        child: SearchCard(
                                            productSale: productSale))),
                              ));
                        }),
                    IconButton(
                      icon: const Icon(Icons.person),
                      tooltip: 'Show profile',
                      onPressed: () async {
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
                body: Container(
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
                                color: Colors.green,
                                products: freshProducts),
                            CustomOutlineButton(
                              text: 'Within one week',
                              color: Colors.yellow,
                              products: nearlyExpiredProducts,
                            ),
                            CustomOutlineButton(
                              text: 'Expired',
                              color: Colors.red,
                              products: expiredProducts,
                            ),
                          ],
                        ),
                        const SizedBox(height: 85),
                        CustomCarousel(
                          text: "Nearby",
                          productsSale: nearbyProducts,
                          user: user,
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
                          text: "Free",
                          productsSale: freeProducts,
                          user: user,
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}

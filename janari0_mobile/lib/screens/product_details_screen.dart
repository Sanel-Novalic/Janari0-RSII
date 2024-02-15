import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:janari0/providers/order_provider.dart';
import '../model/buyer.dart';
import '../model/payment.dart';
import '../model/product_sale.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../model/user.dart';
import '../providers/buyer_provider.dart';
import '../providers/payment_provider.dart';
import '../providers/product_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final User user;
  final ProductSale productSale;
  const ProductDetailsScreen(
      {super.key, required this.productSale, required this.user});
  @override
  State<StatefulWidget> createState() => _ProductDetailsScreen();
}

class _ProductDetailsScreen extends State<ProductDetailsScreen> {
  ProductProvider productProvider = ProductProvider();
  CarouselController carouselController = CarouselController();
  PaymentProvider paymentProvider = PaymentProvider();
  OrderProvider orderProvider = OrderProvider();
  BuyerProvider buyerProvider = BuyerProvider();
  List<String> photoLinks = [];
  int _current = 0;
  var isLoading = false;
  var isNotified = false;
  var isCorrect = true;
  @override
  void initState() {
    super.initState();
    photoLinks.addAll(widget.productSale.product!.photos.map((e) => e.link!));
  }

  void _buildLoading() {
    if (isLoading == true) {
      showDialog(
          context: context,
          builder: (BuildContext build) => const AlertDialog(
                title: Text("Loading.."),
                content: CircularProgressIndicator(),
              ));
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product details'),
      ),
      body: Column(
        children: [
          CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
                enableInfiniteScroll: false,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            items: widget.productSale.product!.photos
                .map((item) => Center(
                    child: Image.network(
                        item.link ??
                            "https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context).size.width)))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: photoLinks.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => carouselController.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(widget.productSale.product!.name!,
                    style: const TextStyle(color: Colors.grey))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  widget.productSale.price == "Free"
                      ? widget.productSale.price
                      : "\$${widget.productSale.price}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 10),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(widget.productSale.description ?? "",
                  style: const TextStyle(color: Colors.grey)),
            ),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () =>
                widget.productSale.price == "Free" ? orderItem() : buyItem(),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: const Text('Order'),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }

  Future<dynamic> _buildDialog(String title, String content) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: Text(
                content,
                style: const TextStyle(
                    color: Color.fromARGB(255, 107, 107, 107), fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Ok")),
              ],
            ));
  }

  buyItem() async {
    bool block = true;
    var tokenKey = 'sandbox_mfhs47gw_r4gzjpxcvzxmfdvg';
    var request = BraintreePayPalRequest(amount: widget.productSale.price);
    Payment payment = Payment();
    payment.successful = false;
    List<Payment> payments = [];
    int paymentsFailed = 0;
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                "Important Information !",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: const Text(
                "You're going to be redirected to Paypal to finish your payment!\nNote: If you want to canel your payment you can do so on PayPal!",
                style: TextStyle(
                    color: Color.fromARGB(255, 107, 107, 107), fontSize: 18),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        block = false;
                      });
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")),
              ],
            ));
    List<Map> items = [];
    Buyer buyerData = Buyer();
    buyerData.userId = widget.user.userId;
    buyerData.status = false;
    var buyer = await buyerProvider.insert(buyerData);
    if (block == false) {
      request = BraintreePayPalRequest(
        amount: widget.productSale.price,
        currencyCode: "USD",
        displayName: "eCodes",
      );
      var result = await Braintree.requestPaypalNonce(tokenKey, request);
      if (result != null) {
        // Call the server-side transaction here
        payment.amount = double.parse(widget.productSale.price);
        payment.buyerId = buyer?.buyerId;
        payment.paymentMethodNonce = result.nonce;
        payment.productSaleId = widget.productSale.productSaleId;
        payment.successful = false;
        Payment? transaction;
        // Check if buyer used loyaltypoints and then add them to payment variabl
        setState(() {
          isLoading = true;
        });
        _buildLoading();
        try {
          transaction = await paymentProvider.beginTransaction(payment);
        } catch (e) {
          await _buildDialog("Error", e.toString());
        }
        setState(() {
          isLoading = false;
        });
        _buildLoading();
        if (transaction?.successful == true) {
          payments.add(transaction!);
          if (!mounted) return;
          await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                    title: Text(
                      "Payment successful!",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    content: Text(
                      "Successfully paid for product ${widget.productSale.product!.name}\nPrice: ${transaction?.amount} EUR ",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              payment.successful = true;
                            });
                            Navigator.pop(context);
                          },
                          child: const Text("Ok")),
                    ],
                  ));
          items.add({
            "productSaleId": widget.productSale.productSaleId,
          });
        }
      } else {
        paymentsFailed++;
        if (!mounted) return;
        await showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: Text(
                    "Important Information !",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  content: Text(
                    "Payment was cancelled for product ${widget.productSale.product!.name}!",
                    style: const TextStyle(
                        color: Color.fromARGB(255, 107, 107, 107),
                        fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            block = false;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text("Ok")),
                  ],
                ));
        return;
      }
    }
    Map order = {
      "items": items,
      "status": true,
      "canceled": false,
      "buyerId": payment.buyerId,
      "price": payment.amount
    };
    if (paymentsFailed == 0) {
      var returnedOrder = await orderProvider.insert(order);
      var insertedOrder = await orderProvider.getById(returnedOrder!.orderId!);
      var output =
          await paymentProvider.saveTransaction(insertedOrder.orderId!);

      if (!mounted) return;
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Text(
                  "Transaction completed successfully",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                content: Text(
                  "Successfully paid for order number: ${insertedOrder.orderNumber}, with total price of ${output?.price} EUR. ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Ok")),
                  TextButton(
                      onPressed: () async {
                        //Navigator.pushNamed(context,
                        //    "${OrderItemsScreen.routeName}/${insertedOrder.orderId}");
                      },
                      child: const Text("Order Details")),
                ],
              ));
    } else {
      await _buildDialog("Payment failed!",
          "Something went wrong with the payment system. Please, try again later!");
    }
  }

  orderItem() async {
    List<Map> items = [];
    items.add({
      "productSaleId": widget.productSale.productSaleId,
    });
    Buyer buyerData = Buyer();
    buyerData.userId = widget.user.userId;
    buyerData.status = false;
    var buyer = await buyerProvider.insert(buyerData);
    Map order = {
      "items": items,
      "status": true,
      "canceled": false,
      "buyerId": buyer?.buyerId,
      "price": 0
    };
    var returnedOrder = await orderProvider.insert(order);
    await paymentProvider.saveTransaction(returnedOrder!.orderId!);
    if (!mounted) return;
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(
                "Order initiated successfully",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              content: Text(
                "Successfully ordered with order number: ${returnedOrder.orderNumber}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Ok")),
                TextButton(
                    onPressed: () async {
                      //Navigator.pushNamed(context,
                      //    "${OrderItemsScreen.routeName}/${insertedOrder.orderId}");
                    },
                    child: const Text("Order Details")),
              ],
            ));
  }
}

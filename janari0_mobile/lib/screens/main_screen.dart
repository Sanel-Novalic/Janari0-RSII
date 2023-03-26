import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:janari0_mobile/model/requests/product_insert_request.dart';
import '../CustomPopupButton.dart';
import '../GenerateImageUrl.dart';
import '../GetImagePermission.dart';
import '../UploadFile.dart';
import '../carousel.dart';
import '../model/product.dart';
import '../test.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<StatefulWidget> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Show QR Code Scanner',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
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
                FirebaseAuth.instance.signOut();
                if (!mounted) return;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MainScreen()));
              },
            ),
          ],
        ),
        floatingActionButton: const Stack(
          children: [ExpandableSponsorFloatingButton()],
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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomOutlineButton(
                        text: 'Fresh', number: 0, color: Colors.green),
                    CustomOutlineButton(
                        text: 'Within one week',
                        number: 3,
                        color: Colors.yellow),
                    CustomOutlineButton(
                        text: 'Expired', number: 11, color: Colors.red),
                  ],
                ),
                const SizedBox(height: 85),
                const CustomCarousel(text: "Nearby"),
                const SizedBox(
                  height: 50,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Image(
                    image: NetworkImage(
                        "https://developers.google.com/static/admob/images/ios-testad-0-admob.png")),
                const CustomCarousel(text: "Nearby"),
              ],
            ),
          ),
        ));
  }
}

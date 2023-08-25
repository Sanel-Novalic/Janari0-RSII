import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:janari0/main.dart';
import 'package:janari0/model/user.dart' as u;
import 'package:janari0/screens/show_orders_screen.dart';
import 'package:janari0/screens/show_products_screen.dart';

import '../model/product.dart';
import 'edit_profile_screen.dart';

class Profile extends StatefulWidget {
  final u.User user;
  final List<Product> products;
  const Profile({super.key, required this.user, required this.products});
  @override
  State<StatefulWidget> createState() => _Profile();
}

class _Profile extends State<Profile> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL ??
                    "https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg"),
                minRadius: 55,
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(widget.user.username),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(widget.user.email, style: GoogleFonts.josefinSans(color: Colors.black))
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: ElevatedButton(
                onPressed: () =>
                    {Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(user: widget.user))).then((value) => setState(() => {}))},
                style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                child: const Text('Edit profile'),
              ),
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Text("Your groceries"),
              )),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5),
              child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.push(context, MaterialPageRoute(builder: (context) => ShowProducts(products: widget.products, text: "All products")))},
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: Colors.black,
                        size: 25,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Products',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: ElevatedButton(
                  onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ShowOrders(user: widget.user, text: "Orders")))},
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.local_shipping,
                        color: Colors.black,
                        size: 25,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Orders',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  )),
            ),
          ),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ElevatedButton(
                onPressed: () => signOut(),
                style: ElevatedButton.styleFrom(minimumSize: const Size(125, 35), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                child: Text(
                  'Sign out',
                  style: GoogleFonts.roboto(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!mounted) return;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
  }
}

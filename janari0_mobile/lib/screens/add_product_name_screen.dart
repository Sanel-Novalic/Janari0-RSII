import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:janari0/model/user.dart' as u;
import 'add_product_full_screen.dart';

class AddProductName extends StatefulWidget {
  final String? name;
  final String? scannedImage;
  final u.User user;
  const AddProductName({super.key, this.name, this.scannedImage, required this.user});
  @override
  State<StatefulWidget> createState() => _AddProductName();
}

class _AddProductName extends State<AddProductName> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(FirebaseAuth.instance.currentUser!.uid);
    if (widget.name != null) nameController.text = widget.name!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a product'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const SizedBox(
              width: double.infinity,
              child: Text(
                'Enter name of the product:',
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              key: widget.key,
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a name',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductFull(
                            name: nameController.text,
                            image: widget.scannedImage,
                            user: widget.user,
                          )));
            },
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: const Text('Next'),
          )
        ],
      ),
    );
  }
}

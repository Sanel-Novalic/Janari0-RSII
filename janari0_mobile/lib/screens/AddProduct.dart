import 'package:flutter/material.dart';

import 'AddProductExpirationDate.dart';

class AddProduct extends StatelessWidget {
  static const String routeName = '/products';
  String name = "Name";
  AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a product'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
              width: double.infinity,
              child: Text(
                'Enter name of the product:',
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a search term',
              ),
              onChanged: (text) {
                name = text;
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddProductExpirationDate(
                            name: name,
                            //storageRepo: StorageRepository(),
                          )));
            },
            child: Text('Next'),
            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          )
        ],
      ),
    );
  }
}

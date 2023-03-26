import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:janari0_mobile/model/requests/product_insert_request.dart';
import '../GenerateImageUrl.dart';
import '../GetImagePermission.dart';
import '../UploadFile.dart';
import '../model/product.dart';

class AddProductExpirationDate extends StatefulWidget {
  static const String routeName = '/productsExpiration';
  final String name;
  late File? image;
  late XFile? photo;
  late List<String> photos;
  TextEditingController dateController = TextEditingController();
  AddProductExpirationDate({super.key, required this.name});

  @override
  State<StatefulWidget> createState() => _AddProductExpirationDate();
}

class _AddProductExpirationDate extends State<AddProductExpirationDate> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  Future pickImage(String source) async {
    try {
      GetImagePermission getPermission = GetImagePermission();
      await getPermission.getPermission(context, source);

      if (getPermission.granted == false) {
        throw 'Permission not granted';
      }

      final image = await ImagePicker().pickImage(
          source:
              source == 'Gallery' ? ImageSource.gallery : ImageSource.camera);

      if (image == null) return;

      setState(() => widget.image = File(image.path));
      final key = DateTime.now().toString();
      final file = File(image.path);
      ProductInsertRequest product = ProductInsertRequest(
          name: widget.name,
          expirationDate: DateTime.parse(widget.dateController.text),
          photos: widget.photos);
      String json = jsonEncode(product);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<void> _showSimpleDialog() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            // <-- SEE HERE
            title: const Text('Take a picture or use a picture from gallery'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  pickImage('Camera');
                  Navigator.of(context).pop();
                },
                child: const Text('Camera'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  pickImage('Gallery');
                  Navigator.of(context).pop();
                },
                child: const Text('Gallery'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
              width: double.infinity,
              child: Text(
                'Add photos from your gallery or take a picture with your camera',
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
            ),
            onPressed: _showSimpleDialog,
            child: Text("Add photo"),
          ),
          SizedBox(
            height: 200,
          ),
          Container(
              width: double.infinity,
              child: Text(
                'Enter expiration date:',
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 200,
          ),
          TextField(
            controller:
                widget.dateController, //editing controller of this TextField
            decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today), //icon of text field
                labelText: "Enter Date" //label text of field
                ),
            readOnly: true, // when true user cannot edit text
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2100));

              if (pickedDate != null) {
                print(
                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(pickedDate);
                print(
                    formattedDate); //formatted date output using intl package =>  2021-03-16
                setState(() {
                  widget.dateController.text =
                      formattedDate; //set output date to TextField value.
                });
              } else {}
            },
          ),
          SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Add product'),
            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
          )
        ],
      ),
    );
  }
}

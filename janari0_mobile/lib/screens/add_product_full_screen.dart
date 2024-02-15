import 'dart:io';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:janari0/model/requests/photo_insert_request.dart';
import 'package:janari0/model/requests/product_insert_request.dart';
import '../providers/product_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:janari0/model/user.dart' as u;

import 'main_screen.dart';

class AddProductFull extends StatefulWidget {
  final String name;
  final String? image;
  final u.User user;
  const AddProductFull(
      {super.key, required this.name, this.image, required this.user});

  @override
  State<StatefulWidget> createState() => _AddProductFull();
}

class _AddProductFull extends State<AddProductFull> {
  late List<PhotoInsertRequest> photosUrl = [];
  TextEditingController dateController = TextEditingController();
  final ProductProvider productProvider = ProductProvider();
  final User? user = FirebaseAuth.instance.currentUser;
  List<UploadJob>? _pictures = [];
  bool isUploading = false;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
                width: double.infinity,
                child: Text(
                  'Add photos from your gallery or take a picture with your camera',
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 20,
            ),
            PictureUploadWidget(
              storageInstance: FirebaseStorage.instance,
              initialImages: _pictures,
              onPicturesChange: pictureCallback,
              buttonStyle: PictureUploadButtonStyle(),
              buttonText: 'Upload Picture',
              localization: PictureUploadLocalization(),
              settings: PictureUploadSettings(
                  customUploadFunction: uploadPicture,
                  imageSource: ImageSourceExtended.askUser,
                  minImageCount: 0,
                  maxImageCount: 5,
                  imageManipulationSettings: const ImageManipulationSettings(
                      enableCropping: false, compressQuality: 25)),
              enabled: true,
            ),
            const SizedBox(
              height: 60,
            ),
            const SizedBox(
                width: double.infinity,
                child: Text(
                  'Enter expiration date:',
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: TextField(
                controller:
                    dateController, //editing controller of this TextField
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
                    //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate = DateFormat('yyyy-MM-dd').format(
                        pickedDate); //formatted date output using intl package =>  2021-03-16
                    setState(() {
                      dateController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: isUploading ? null : () => uploadProduct(),
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Add product'),
            )
          ],
        ),
      ),
    );
  }

  Future<Reference> uploadPicture(CroppedFile file, int id) async {
    Reference imgRef =
        FirebaseStorage.instance.ref().child("images/${user!.uid}/${id}_800");
    setState(() {
      isUploading = true;
    });
    await imgRef.putFile(File(file.path));
    setState(() {
      isUploading = false;
    });
    return imgRef;
  }

  Future<void> uploadProduct() async {
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You need to set an expiration date')));
    }
    try {
      for (var picture in _pictures!) {
        Reference? ref = picture.storageReference;
        if (ref != null) {
          photosUrl.add(PhotoInsertRequest(
              link: await picture.storageReference?.getDownloadURL()));
        }
      }
    } on FirebaseException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.code)));
      return;
    }
    ProductInsertRequest product = ProductInsertRequest(
        name: widget.name,
        expirationDate: DateTime.parse(dateController.text),
        photos: photosUrl,
        userId: widget.user.userId);
    var returnedProduct = await productProvider.insert(product);
    if (!mounted) return;
    if (returnedProduct == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong while inserting the product')));
      return;
    }
    photosUrl.clear();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully added the product')));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  void pictureCallback(
      {List<UploadJob>? uploadJobs, bool? pictureUploadProcessing}) {
    _pictures = uploadJobs;
  }
}

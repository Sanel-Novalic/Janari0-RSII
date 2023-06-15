import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_picture_uploader/firebase_picture_uploader.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0/model/user.dart' as u;
import 'package:janari0/screens/change_email_screen.dart';
import 'package:janari0/screens/change_password_screen.dart';
import 'package:janari0/screens/change_phone_number_screen.dart';
import 'package:janari0/screens/change_username_screen.dart';
import '../utils/long_white_button.dart';

class EditProfile extends StatefulWidget {
  final u.User user;
  const EditProfile({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  UserProvider userProvider = UserProvider();
  List<UploadJob>? _pictures = [];
  @override
  void initState() {
    super.initState();
  }

  navigate() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeUsernameScreen(user: widget.user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                        minImageCount: 1,
                        maxImageCount: 1,
                        imageManipulationSettings:
                            const ImageManipulationSettings(
                                enableCropping: false, compressQuality: 75)),
                    enabled: true,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () => changePicture(),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  child: const Text("Change profile picture")),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          LongWhiteButton(
              text: "Username",
              value: widget.user.username,
              user: widget.user,
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChangeUsernameScreen(user: widget.user)))),
          LongWhiteButton(
            text: "Email",
            value: widget.user.email,
            user: widget.user,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangeEmailScreen(user: widget.user))),
          ),
          LongWhiteButton(
            text: "Phone number",
            value: widget.user.phoneNumber!,
            user: widget.user,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangePhoneNumberScreen(user: widget.user))),
          ),
          LongWhiteButton(
            text: "Password",
            value: "*********",
            user: widget.user,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ChangePasswordScreen(user: widget.user))),
          ),
        ],
      ),
    );
  }

  void pictureCallback(
      {List<UploadJob>? uploadJobs, bool? pictureUploadProcessing}) {
    _pictures = uploadJobs;
  }

  Future<void> changePicture() async {
    debugPrint(_pictures!.length.toString());
    var picture = _pictures?.first;
    var link = await picture!.storageReference!.getDownloadURL();

    await FirebaseAuth.instance.currentUser!.updatePhotoURL(link);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully updated the picture')));
  }

  Future<Reference> uploadPicture(CroppedFile file, int id) async {
    Reference imgRef = FirebaseStorage.instance.ref().child(
        "images/${FirebaseAuth.instance.currentUser!.uid}/profile/${id}_800");

    await imgRef.putFile(File(file.path));

    return imgRef;
  }
}

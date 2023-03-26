import 'dart:convert';
import 'dart:io';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:janari0_mobile/model/requests/product_insert_request.dart';
import 'package:janari0_mobile/providers/user_provider.dart';
import '../CustomPopupButton.dart';
import '../GenerateImageUrl.dart';
import '../GetImagePermission.dart';
import '../UploadFile.dart';
import '../carousel.dart';
import '../model/product.dart';
import '../model/requests/user_insert_request.dart';
import '../test.dart';
import '../utils/custom_form_field.dart';
import 'main_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordRepeat = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  bool valid = false;
  UserProvider? userProvider = UserProvider();
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
        body: SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/welcome_background_better_better.png'),
                fit: BoxFit.fill,
                opacity: 1)),
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
                width: double.infinity,
                child: Text(
                  'Hello there!',
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFormField().field(
                controller: username,
                question: "Name",
                canBeNull: false,
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle:
                    TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.person,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFormField().field(
                controller: email,
                question: "Email",
                canBeNull: false,
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle:
                    TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.email,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFormField().field(
                controller: password,
                question: "Password",
                canBeNull: false,
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle:
                    TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.key,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomFormField().field(
                controller: passwordRepeat,
                question: "Repeat password",
                canBeNull: false,
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle:
                    TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.key,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {
                  phoneNumber.text = phone.completeNumber;
                  print(phoneNumber.text);
                },
              ),
              //child: PhoneNumberInput(
              //  controller: _phonecontroller,
              //  initialCountry: 'BA',
              //  countryListMode: CountryListMode.dialog,
              //  enabledBorder: OutlineInputBorder(
              //      borderRadius: BorderRadius.circular(10),
              //      borderSide: const BorderSide(color: Colors.white)),
              //  focusedBorder: OutlineInputBorder(
              //      borderRadius: BorderRadius.circular(10),
              //      borderSide: const BorderSide(color: Colors.white)),
              //  allowPickFromContacts: false,
              //  border: OutlineInputBorder(
              //      borderRadius: BorderRadius.circular(10),
              //      borderSide: const BorderSide(color: Colors.white)),
              //  errorText: 'Incorrect format',
              //  onChanged: (phoneNumber) => print(_phonecontroller.phoneNumber),
              //),
            ),
            ElevatedButton(
              onPressed: () => registerUser(),
              child: Text('Register'),
              style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            ),
          ],
        ),
      ),
    ));
  }

  registerUser() async {
    try {
      print(phoneNumber.text);
      UserInsertRequest user = UserInsertRequest();
      user.username = username.text;
      user.email = email.text;
      user.phoneNumber = phoneNumber.text;
      await userProvider!.insert(user);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}

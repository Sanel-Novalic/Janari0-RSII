import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:janari0/model/requests/location_CU_request.dart';
import 'package:janari0/providers/user_provider.dart';
import '../model/requests/user_insert_request.dart';
import '../model/requests/user_update_request.dart';
import '../utils/custom_form_field.dart';

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
  UserProvider userProvider = UserProvider();
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(
              height: 50,
            ),
            const SizedBox(
                width: double.infinity,
                child: Text(
                  'Hello there!',
                  textAlign: TextAlign.center,
                )),
            const SizedBox(
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
                    const TextStyle(color: Colors.black, background: null),
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
                    const TextStyle(color: Colors.black, background: null),
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
                    const TextStyle(color: Colors.black, background: null),
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
                    const TextStyle(color: Colors.black, background: null),
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
                  debugPrint(phoneNumber.text);
                },
              ),
            ),
            ElevatedButton(
              onPressed: () => registerUser(),
              style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    ));
  }

  registerUser() async {
    try {
      debugPrint(phoneNumber.text);
      int id = 1;
      await userProvider.get(null).then((value) => id = value.length);
      LocationCURequest locationInsertRequest =
          LocationCURequest(latitude: 0, longitude: 0);
      UserInsertRequest user = UserInsertRequest(
          email: email.text,
          username: username.text,
          phoneNumber: phoneNumber.text,
          location: locationInsertRequest);
      await userProvider.insert(user);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      debugPrint("AWDA");
      var userUpdateRequest =
          UserUpdateRequest(uid: FirebaseAuth.instance.currentUser!.uid);
      userProvider.update(id + 1, userUpdateRequest);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

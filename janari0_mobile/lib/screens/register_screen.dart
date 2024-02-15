import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:janari0/model/requests/location_CU_request.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0/screens/main_screen.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
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
                    initialCountryCode: 'BA',
                    validator: (p0) {
                      if (p0!.number.length == 8 || p0.number.length == 9) {
                        valid = true;
                        return null;
                      }
                      valid = false;
                      return 'Invalid phone number';
                    },
                    disableLengthCheck: true,
                    onChanged: (phone) {
                      phoneNumber.text = phone.completeNumber;
                      debugPrint(phoneNumber.text);
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: valid == false ? null : () => registerUser(),
                  style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
                  child: const Text('Register'),
                ),
              ],
            ),
          ),
        ));
  }

  registerUser() async {
    int id = 1;
    try {
      LocationCURequest locationInsertRequest =
          LocationCURequest(latitude: 0, longitude: 0);
      if (email.text.isEmpty ||
          username.text.isEmpty ||
          phoneNumber.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please input all fields')));
        return;
      }
      UserInsertRequest user = UserInsertRequest(
          email: email.text,
          username: username.text,
          phoneNumber: phoneNumber.text,
          location: locationInsertRequest);
      var returnedUser = await userProvider.insert(user);
      if (!mounted) return;
      if (returnedUser == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('One or more fields are invalid')));
        return;
      }
      id = returnedUser.userId;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );
      var userUpdateRequest =
          UserUpdateRequest(uid: FirebaseAuth.instance.currentUser!.uid);
      var updatedUser = await userProvider.update(id, userUpdateRequest);
      if (updatedUser == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong..')));
        return;
      }
      if (!mounted) return;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
      userProvider.delete(id);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('One or more inputs are invalid')));
    }
  }
}

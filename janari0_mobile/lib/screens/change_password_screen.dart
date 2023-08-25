import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0/model/user.dart' as u;
import '../utils/custom_form_field.dart';
import 'main_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final u.User user;
  const ChangePasswordScreen({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  UserProvider userProvider = UserProvider();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change password'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomFormField().field(
                controller: currentPasswordController,
                question: "Current password",
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle: const TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.key,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
                borderColor: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomFormField().field(
                controller: newPasswordController,
                question: "New password",
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle: const TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.key,
                  color: Colors.grey,
                  size: 25,
                ),
                fieldTextFontSize: 15,
                borderColor: Colors.black),
          ),
          const SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: () => updateUser(),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  updateUser() async {
    try {
      var result = await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(
          EmailAuthProvider.credential(email: FirebaseAuth.instance.currentUser!.email!, password: currentPasswordController.text));
      await result.user!.updatePassword(newPasswordController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully updated the password')));
      Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong current password')));
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
    }
  }
}

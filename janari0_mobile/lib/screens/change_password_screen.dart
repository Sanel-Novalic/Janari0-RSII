import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:janari0_mobile/providers/user_provider.dart';
import 'package:janari0_mobile/model/user.dart' as u;
import '../utils/custom_form_field.dart';
import 'main_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String routeName = "/change_password";
  final u.User user;
  const ChangePasswordScreen({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => _ChangePasswordScreen();
}

class _ChangePasswordScreen extends State<ChangePasswordScreen> {
  UserProvider userProvider = UserProvider();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    print(widget.user.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change username'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomFormField().field(
                controller: controller,
                question: "Password",
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
    print(widget.user.userId);

    await FirebaseAuth.instance.currentUser!.updatePassword(controller.text);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully updated the email')));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }
}

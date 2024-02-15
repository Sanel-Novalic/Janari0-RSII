import 'package:flutter/material.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0/model/user.dart' as u;
import '../utils/custom_form_field.dart';
import 'main_screen.dart';

class ChangeUsernameScreen extends StatefulWidget {
  final u.User user;
  const ChangeUsernameScreen({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => _ChangeUsernameScreen();
}

class _ChangeUsernameScreen extends State<ChangeUsernameScreen> {
  UserProvider userProvider = UserProvider();
  TextEditingController usernameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    usernameController.text = widget.user.username;
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
                controller: usernameController,
                question: "Username",
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
                borderColor: Colors.black),
          ),
          const SizedBox(
            height: 60,
          ),
          ElevatedButton(
            onPressed: () => updateUsername(),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  updateUsername() async {
    widget.user.username = usernameController.text;
    var user = await userProvider.update(widget.user.userId, widget.user);

    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Either the username already exists or the username is invalid')));
      return;
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully updated the username')));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }
}

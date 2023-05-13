import 'package:flutter/material.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0_admin/screens/main/main_screen.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    String username = "";
    String password = "";
    return Scaffold(
        body: Column(
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
          height: 350,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Username',
            ),
            onChanged: (text) {
              username = text;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Password',
            ),
            onChanged: (text) {
              password = text;
            },
          ),
        ),
        ElevatedButton(
          onPressed: () => loginUser(username, password, context),
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('Login'),
        ),
      ],
    ));
  }

  Future loginUser(
      String username, String password, BuildContext context) async {
    UserProvider userProvider = UserProvider();
    await userProvider.login(username, password);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const MainScreen()));
  }
}

import 'package:flutter/material.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0_admin/screens/main/main_screen.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";
    return Scaffold(
        body: SingleChildScrollView(
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
            height: 350,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              onChanged: (text) {
                email = text;
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
            onPressed: () => loginUser(email, password, context),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: const Text('Login'),
          ),
        ],
      ),
    ));
  }

  Future loginUser(String email, String password, BuildContext context) async {
    UserProvider userProvider = UserProvider();
    try {
      await userProvider.signInWithEmailPasswordAdmin(email, password);
      if (context.mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
      return;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0/model/user.dart' as u;
import '../utils/custom_form_field.dart';
import 'main_screen.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  final u.User user;
  const ChangePhoneNumberScreen({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => _ChangePhoneNumberScreen();
}

class _ChangePhoneNumberScreen extends State<ChangePhoneNumberScreen> {
  UserProvider userProvider = UserProvider();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.text = widget.user.phoneNumber!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change phone number'),
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
                question: "Phone number",
                horizontalTextPadding: 20,
                verticalTextPadding: 10,
                labelTextStyle:
                    const TextStyle(color: Colors.black, background: null),
                icon: const Icon(
                  Icons.phone,
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
    widget.user.phoneNumber = controller.text;
    try {
      var user = await userProvider.update(widget.user.userId, widget.user);
      if (user == null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This phone number is taken')));
        return;
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Successfully updated the phone number')));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const MainScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}

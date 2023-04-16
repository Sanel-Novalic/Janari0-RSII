import 'package:flutter/material.dart';
import 'package:janari0_mobile/providers/user_provider.dart';
import 'package:janari0_mobile/model/user.dart' as u;
import 'package:janari0_mobile/screens/change_username_screen.dart';
import '../utils/long_white_button.dart';

class EditProfile extends StatefulWidget {
  static const String routeName = "/edit_profile";
  final u.User user;
  const EditProfile({super.key, required this.user});
  @override
  State<StatefulWidget> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  UserProvider userProvider = UserProvider();
  @override
  void initState() {
    super.initState();
    print(widget.user.userId);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://assets.bonappetit.com/photos/63a390eda38261d1c3bdc555/4:5/w_1920,h_2400,c_limit/best-food-writing-2022-lede.jpg"),
                minRadius: 65,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Change picture"),
          const SizedBox(
            height: 20,
          ),
          LongWhiteButton(
              text: "Username",
              value: widget.user.username,
              user: widget.user,
              onPressed: () => navigate()),
          LongWhiteButton(
            text: "Email",
            value: widget.user.email,
            user: widget.user,
            onPressed: () => navigate(),
          ),
          LongWhiteButton(
            text: "Phone number",
            value: widget.user.phoneNumber,
            user: widget.user,
            onPressed: () => navigate(),
          ),
          LongWhiteButton(
            text: "Password",
            value: "*********",
            user: widget.user,
            onPressed: () => navigate(),
          ),
        ],
      ),
    );
  }
}

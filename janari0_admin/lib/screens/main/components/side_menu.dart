import 'package:flutter/material.dart';
import 'package:janari0_admin/controllers/menu_app_controller.dart';
import 'package:janari0_admin/screens/login.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var drawer = Provider.of<MenuAppController>(context, listen: false);
    return Drawer(
      child: Column(children: [
        DrawerHeader(
          child: Image.asset("assets/images/logo.png"),
        ),
        DrawerListTile(
          title: "Users",
          press: () {
            drawer.setCurrentDrawer(0);
          },
        ),
        DrawerListTile(
          title: "Products",
          press: () {
            drawer.setCurrentDrawer(1);
          },
        ),
        DrawerListTile(
          title: "ProductsSale",
          press: () {
            drawer.setCurrentDrawer(2);
          },
        ),
        DrawerListTile(
          title: "Orders",
          press: () {
            drawer.setCurrentDrawer(3);
          },
        ),
        DrawerListTile(
          title: "Output",
          press: () {
            drawer.setCurrentDrawer(4);
          },
        ),
        Expanded(
          child: Align(
            alignment: FractionalOffset.bottomCenter,
            child: DrawerListTile(
              title: "Log out",
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
            ),
          ),
        ),
      ]),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}

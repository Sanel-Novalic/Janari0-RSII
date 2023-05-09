import 'package:flutter/material.dart';
import 'package:janari0/model/user.dart';
import 'package:janari0_admin/controllers/MenuAppController.dart';
import 'package:provider/provider.dart';

import '../../show_users.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var drawer = Provider.of<MenuAppController>(context, listen: false);
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            press: () {},
          ),
          DrawerListTile(
            title: "Users",
            press: () {
              //drawer.setCurrentDrawer(0);
            },
          ),
          DrawerListTile(
            title: "Products",
            press: () {},
          ),
          DrawerListTile(
            title: "ProductsSale",
            press: () {},
          ),
          DrawerListTile(
            title: "Orders",
            press: () {},
          ),
          DrawerListTile(
            title: "Output",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            press: () {},
          ),
        ],
      ),
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
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:janari0/model/user.dart';
import 'package:janari0/providers/user_provider.dart';
import 'package:janari0_admin/controllers/MenuAppController.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';

class DashboardScreen extends StatefulWidget {
  static const String routeName = "/main";
  const DashboardScreen({super.key});

  @override
  State<StatefulWidget> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  UserProvider userProvider = UserProvider();
  List<User> users = [];
  List<Widget> widgets = [];
  late Future<List<User>> myFuture;
  @override
  void initState() {
    super.initState();
    myFuture = loadData();
  }

  Future<List<User>> loadData() async {
    print("ADWAs");
    var data = userProvider.get();
    print("ADWAddd");
    setState(() {
      data.then((value) => users = value);
    });
    return users;
  }

  @override
  Widget build(BuildContext context) {
    var drawer = Provider.of<MenuAppController>(context, listen: true);
    return FutureBuilder(
      future: myFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        return Column(
          children: [
            const SizedBox(height: defaultPadding),
            if (widgets.isNotEmpty) widgets[drawer.getCurrentDrawer],
          ],
        );
      },
    );
  }

  DataRow userRow(User info) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(info.userId as String),
              ),
            ],
          ),
        ),
        DataCell(Text(info.username)),
        DataCell(Text(info.email)),
        DataCell(Text(info.phoneNumber)),
        //DataCell(Text(info.uid)),
      ],
    );
  }

  void createWidgets() {
    // Users
    widgets.add(Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Users",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable(
              columnSpacing: defaultPadding,
              // minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("UserID"),
                ),
                DataColumn(
                  label: Text("Username"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Phone number"),
                ),
                DataColumn(
                  label: Text("Uid"),
                ),
              ],
              rows: List.generate(
                users.length,
                (index) => userRow(users[index]),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

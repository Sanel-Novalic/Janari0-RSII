import 'package:flutter/material.dart';
import 'package:janari0/model/user.dart';

import '../../../constants.dart';

class ShowData extends StatelessWidget {
  static const String routeName = "/users";
  final List<User> users;
  const ShowData({Key? key, required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                (index) => dataRow(users[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow dataRow(User info) {
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

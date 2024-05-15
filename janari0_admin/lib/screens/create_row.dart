import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janari0/model/order.dart';
import 'package:janari0/model/output.dart';
import 'package:janari0/model/product.dart';
import 'package:janari0/model/product_sale.dart';
import 'package:janari0/model/requests/location_CU_request.dart';
import 'package:janari0/model/requests/product_insert_request.dart';
import 'package:janari0/model/requests/product_sale_insert_request.dart';
import 'package:janari0/model/requests/user_insert_request.dart';
import 'package:janari0/model/requests/user_update_request.dart';
import 'package:janari0/model/user.dart' as u;
import 'package:janari0_admin/screens/dashboard/dashboard_screen.dart';
import 'package:janari0_admin/utils/custom_field.dart';

class CreateRow extends StatefulWidget {
  final dynamic row;
  const CreateRow({super.key, required this.row});

  @override
  State<StatefulWidget> createState() => _CreateRow();
}

class _CreateRow extends State<CreateRow> {
  TextEditingController controller = TextEditingController();
  late Widget fields;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.row == TABLE.users) {
      return userData();
    }
    if (widget.row == TABLE.products) {
      return productData();
    }
    if (widget.row == TABLE.productsSale) {
      return productSaleData();
    }
    if (widget.row == TABLE.orders) {
      return orderData();
    }
    return outputData();
  }

  Widget userData() {
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 70,
        ),
        CustomField(controller: usernameController, question: "Username"),
        CustomField(
            controller: phoneNumberController, question: "Phone number"),
        CustomField(controller: emailController, question: "Email"),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () async {
            LocationCURequest locationInsertRequest =
                LocationCURequest(latitude: 0, longitude: 0);
            UserInsertRequest user = UserInsertRequest(
                email: emailController.text,
                username: usernameController.text,
                phoneNumber: phoneNumberController.text,
                location: locationInsertRequest);
            try {
              await userProvider.insert(user);
              if (!mounted) return;
              Navigator.pop(context, 'Created');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    e.toString(),
                  )));
            }
          },
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('Create a row'),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Material(
              child: InkWell(
                onTap: () => {Navigator.pop(context)},
                child: const Text(
                  'Back to list',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget productData() {
    TextEditingController expirationDateController = TextEditingController();
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 70,
        ),
        CustomField(controller: controller, question: "Name"),
        GestureDetector(
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              expirationDateController.text = formattedDate;
            }
          },
          child: AbsorbPointer(
            child: CustomField(
              controller: expirationDateController,
              question: "Expiration date",
            ),
          ),
        ),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              ProductInsertRequest product = ProductInsertRequest(
                  name: controller.text,
                  expirationDate: DateTime.parse(expirationDateController.text),
                  userId: 1);
              await productProvider.insert(product);
              if (!mounted) return;
              Navigator.pop(context, 'Created');
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('Create a row'),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Material(
              child: InkWell(
                onTap: () => {Navigator.pop(context)},
                child: const Text(
                  'Back to list',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget productSaleData() {
    TextEditingController descriptionController = TextEditingController();
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 70,
        ),
        CustomField(controller: controller, question: "Price"),
        CustomField(controller: descriptionController, question: "Description"),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              await productSaleProvider.insert(ProductSaleInsertRequest(
                  productId: 1,
                  price: controller.text,
                  description: descriptionController.text,
                  locationId: 1));
              if (!mounted) return;
              Navigator.pop(
                  context, 'Successfully updated the productSale row');
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('Create a row'),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Material(
              child: InkWell(
                onTap: () => {Navigator.pop(context)},
                child: const Text(
                  'Back to list',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget orderData() {
    TextEditingController canceledContoller = TextEditingController();
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 70,
        ),
        CustomField(controller: controller, question: "Status"),
        CustomField(controller: canceledContoller, question: "Canceled"),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              //await orderProvider.update(row.orderId!, row);
              if (!mounted) return;
              Navigator.pop(context, 'Successfully updated the order row');
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('Create a row'),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Material(
              child: InkWell(
                onTap: () => {Navigator.pop(context)},
                child: const Text(
                  'Back to list',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget outputData() {
    TextEditingController concludedController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 70,
        ),
        CustomField(controller: controller, question: "Payment method"),
        CustomField(controller: concludedController, question: "Concluded"),
        CustomField(controller: amountController, question: "Amount"),
        const SizedBox(
          height: 60,
        ),
        ElevatedButton(
          onPressed: () async {
            try {
              //await outputProvider.update(row.outputId!, row);
              if (!mounted) return;
              Navigator.pop(context, 'Successfully updated the output row');
            } catch (e) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          },
          style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          child: const Text('Create a row'),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Material(
              child: InkWell(
                onTap: () => {Navigator.pop(context)},
                child: const Text(
                  'Back to list',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

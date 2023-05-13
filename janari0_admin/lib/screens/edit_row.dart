import 'package:flutter/material.dart';
import 'package:janari0/model/order.dart';
import 'package:janari0/model/output.dart';
import 'package:janari0/model/product.dart';
import 'package:janari0/model/product_sale.dart';
import 'package:janari0/model/requests/user_update_request.dart';
import 'package:janari0/model/user.dart' as u;
import 'package:janari0_admin/screens/dashboard/dashboard_screen.dart';
import 'package:janari0_admin/utils/custom_field.dart';

class EditRow extends StatefulWidget {
  final dynamic row;
  const EditRow({super.key, required this.row});

  @override
  State<StatefulWidget> createState() => _EditRow();
}

class _EditRow extends State<EditRow> {
  TextEditingController controller = TextEditingController();
  late Widget fields;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.row is u.User) {
      return userData(widget.row as u.User);
    }
    if (widget.row is Product) {
      return productData(widget.row as Product);
    }
    if (widget.row is ProductSale) {
      return productSaleData(widget.row as ProductSale);
    }
    if (widget.row is Order) {
      return orderData(widget.row as Order);
    }
    return outputData(widget.row as Output);
  }

  Widget userData(u.User row) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    usernameController.text = row.username;
    phoneNumberController.text = row.phoneNumber!;
    return Column(children: [
      const SizedBox(
        height: 70,
      ),
      CustomField(controller: usernameController, question: "Username"),
      CustomField(controller: phoneNumberController, question: "phoneNumber"),
      const SizedBox(
        height: 60,
      ),
      ElevatedButton(
        // Update user
        onPressed: () async {
          UserUpdateRequest userUpdateRequest = UserUpdateRequest(
              username: usernameController.text == row.username
                  ? null
                  : usernameController.text,
              phoneNumber: phoneNumberController.text == row.phoneNumber
                  ? null
                  : phoneNumberController.text);

          await userProvider.update(row.userId, userUpdateRequest);

          row.username = usernameController.text;
          row.phoneNumber = phoneNumberController.text;

          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.white,
              content: Text(
                'Successfully updated the user',
              )));
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        child: const Text('Save'),
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
    ]);
  }

  Widget productData(Product row) {
    controller.text = row.name!;
    return Column(children: [
      const SizedBox(
        height: 70,
      ),
      CustomField(controller: controller, question: "Name"),
      const SizedBox(
        height: 60,
      ),
      ElevatedButton(
        onPressed: () async {
          row.name = controller.text;
          await productProvider.update(row.productId!, row);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Successfully updated the product')));
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        child: const Text('Save'),
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
    ]);
  }

  Widget productSaleData(ProductSale row) {
    TextEditingController descriptionContoller = TextEditingController();
    controller.text = row.price;
    descriptionContoller.text = row.description!;
    return Column(children: [
      const SizedBox(
        height: 70,
      ),
      CustomField(controller: controller, question: "Price"),
      CustomField(controller: descriptionContoller, question: "Description"),
      const SizedBox(
        height: 60,
      ),
      ElevatedButton(
        onPressed: () async {
          row.price = controller.text;
          row.description = descriptionContoller.text;
          await productSaleProvider.update(row.productSaleId!, row);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Successfully updated the productSale')));
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        child: const Text('Save'),
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
    ]);
  }

  Widget orderData(Order row) {
    TextEditingController canceledContoller = TextEditingController();
    controller.text = row.status.toString();
    canceledContoller.text = row.canceled.toString();
    return Column(children: [
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
          row.status = controller.text == "true" ? true : false;
          row.canceled = controller.text == "true" ? true : false;
          await orderProvider.update(row.orderId!, row);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully updated the order')));
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        child: const Text('Save'),
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
    ]);
  }

  Widget outputData(Output row) {
    TextEditingController concludedController = TextEditingController();
    TextEditingController amountController = TextEditingController();
    controller.text = row.paymentMethod!;
    concludedController.text = row.concluded.toString();
    amountController.text = row.amount.toString();
    return Column(children: [
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
          row.paymentMethod = controller.text;
          row.concluded = concludedController.text == "true" ? true : false;
          row.amount = double.parse(amountController.text);
          await outputProvider.update(row.outputId!, row);
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Successfully updated the output')));
          Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
        child: const Text('Save'),
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
    ]);
  }
}

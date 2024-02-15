import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:janari0/model/requests/product_sale_insert_request.dart';
import 'package:janari0/providers/product_sale_provider.dart';
import 'package:janari0/screens/product_details_screen.dart';
import '../model/product.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../model/product_sale.dart';
import '../model/user.dart';
import '../utils/multi_line_text.dart';

class DonateProductScreen extends StatefulWidget {
  final List<Product> products;
  final bool hasPrice;
  final User user;
  const DonateProductScreen(
      {super.key,
      required this.products,
      required this.hasPrice,
      required this.user});

  @override
  State<StatefulWidget> createState() => _DonateProductScreen();
}

class _DonateProductScreen extends State<DonateProductScreen> {
  GlobalKey globalKey = GlobalKey();
  ProductSaleProvider productSaleProvider = ProductSaleProvider();
  TextEditingController productSearchController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Product? product;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    priceController.text = widget.hasPrice ? '' : 'Free';
    return Scaffold(
      appBar: AppBar(
        title: const Text("Put product on sale"),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Form(
          child: SingleChildScrollView(
            reverse: true,
            padding: const EdgeInsets.only(bottom: 10),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(
                        width: double.infinity,
                        child: Text(
                          'Select a product from your grocery list',
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownSearch<Product>(
                      items: widget.products,
                      clearButtonProps: const ClearButtonProps(isVisible: true),
                      popupProps: PopupProps.modalBottomSheet(
                        showSelectedItems: true,
                        itemBuilder: _customPopupItemBuilderExample2,
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(
                          controller: productSearchController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                productSearchController.clear();
                              },
                            ),
                          ),
                        ),
                      ),
                      compareFn: (item, selectedItem) =>
                          item.name == selectedItem.name,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          labelText: 'Products',
                          filled: true,
                          fillColor:
                              Theme.of(context).inputDecorationTheme.fillColor,
                        ),
                      ),
                      dropdownBuilder: _customDropDownExample,
                      onChanged: (value) => product = value,
                    ),
                    const Spacer(),
                    MultiLineTextField(
                      controller: descriptionController,
                      globalKey: globalKey,
                    ),
                    Visibility(
                      visible: widget.hasPrice,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 120,
                              height: 50,
                              child: TextField(
                                textAlignVertical: TextAlignVertical.center,
                                controller: priceController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Price',
                                    labelText: 'Price',
                                    contentPadding: EdgeInsets.only(left: 12)),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'(^\d*\.?\d*)'))
                                ],
                              ),
                            ),
                            const Icon(Icons.attach_money)
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => createProductSale(),
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder()),
                      child: const Text('Submit'),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _customPopupItemBuilderExample2(
      BuildContext context, Product item, bool isSelected) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.name!),
        //subtitle: Text(item.createdAt.toString()),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.photos.first.link!),
        ),
      ),
    );
  }

  Widget _customDropDownExample(BuildContext context, Product? item) {
    if (item == null) {
      return const ListTile(
        contentPadding: EdgeInsets.all(0),
        leading: CircleAvatar(),
        title: Text("No item selected"),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item.photos.first.link!),
        ),
        title: Text(item.name!),
      ),
    );
  }

  createProductSale() async {
    if (product == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a product for sale')));
      return;
    }
    if (widget.hasPrice && priceController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a price for the product')));
      return;
    }
    var returnedProductSale = await productSaleProvider.insert(
        ProductSaleInsertRequest(
            productId: product!.productId!,
            price: priceController.text,
            description: descriptionController.text,
            locationId: widget.user.locationId!));
    if (!mounted) return;
    if (returnedProductSale == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Something went wrong while adding the product on sale')));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Successfully added product on sale')));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
                  productSale: ProductSale(
                      product: product!,
                      price: priceController.text,
                      description: descriptionController.text),
                  user: widget.user,
                )));
  }
}

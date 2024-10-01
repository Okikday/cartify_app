import 'dart:io';
import 'package:cartify/app.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/data/storage/product_data.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_dialog.dart';
import 'package:cartify/views/pages/elements/custom_dropdown_menu.dart';
import 'package:cartify/views/pages/pages/update_role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cartify/services/product_services.dart';

class UploadProduct extends ConsumerStatefulWidget {
  const UploadProduct({super.key});

  @override
  ConsumerState<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends ConsumerState<UploadProduct> {
  String productName = "";
  String productDetails = "";
  int productPrice = 0;
  String category = ProductData.categories.first;
  double discountPercentage = 0;
  int units = 1;
  File? imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final String result = await HiveData().getData(key: 'role');
      if (result != 'vendor') {
        if (globalNavKey.currentContext!.mounted) {
          Navigator.pushReplacement(globalNavKey.currentContext!, MaterialPageRoute(builder: (context) => const UpdateRole()));
          DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Make yourself a vendor to upload a product");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ConstantWidgets.text(context, "Upload your product", fontSize: 14, fontWeight: FontWeight.bold),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(
                height: 48,
              ),
              CustomTextfield(
                screenWidth: 80,
                borderRadius: 14,
                prefixIcon: Icon(
                  Icons.abc,
                  color: CartifyColors.royalBlue.withAlpha(200),
                ),
                hintStyle: const TextStyle(fontSize: 15),
                hint: "Enter the product name",
                onchanged: (text) => setState(() => productName = text),
              ),

              const SizedBox(
                height: 36,
              ),

              CustomTextfield(
                screenWidth: 80,
                borderRadius: 12,
                maxLines: 8,
                pixelHeight: 200,
                backgroundColor: CartifyColors.royalBlue.withAlpha(25),
                contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                hintStyle: const TextStyle(fontSize: 15),
                hint: "Enter the product Description",
                onchanged: (text) => setState(() => productDetails = text),
              ),

              const SizedBox(
                height: 36,
              ),

              CustomDropdownMenu(
                hintText: "Select a Product category",
                width: screenWidth * 0.8,
                dropdownEntryItems: ProductData.categories,
                menuLabel: ConstantWidgets.text(
                  context,
                  "Select a product category",
                  fontWeight: FontWeight.bold,
                ),
                trailingIcon: const Icon(Icons.arrow_drop_down_circle_outlined),
                textStyle: TextStyle(color: DeviceUtils.isDarkMode(context) ? Colors.white : Colors.black),
                leadingIcon: const Icon(Icons.merge_type_outlined),
                onselected: (selected) => setState(() => category = selected),
              ),

              const SizedBox(
                height: 36,
              ),

              CustomTextfield(
                screenWidth: 80,
                borderRadius: 36,
                keyboardType: const TextInputType.numberWithOptions(),
                prefixIcon: Icon(
                  Icons.monetization_on_outlined,
                  color: CartifyColors.royalBlue.withAlpha(200),
                ),
                hintStyle: const TextStyle(fontSize: 14),
                hint: "Enter the price of the product",
                onchanged: (text) {
                  final converted = int.tryParse(text);
                  if (converted != null) {
                    setState(() => productPrice = converted);
                  } else {
                    setState(() => productPrice = 0);
                  }
                },
              ),

              const SizedBox(
                height: 36,
              ),

              CustomTextfield(
                screenWidth: 80,
                borderRadius: 36,
                keyboardType: TextInputType.number,
                prefixIcon: Icon(
                  Icons.percent,
                  color: CartifyColors.royalBlue.withAlpha(200),
                ),
                hintStyle: const TextStyle(fontSize: 14),
                hint: "Enter the Discount in percentage",
                onchanged: (text) {
                  final converted = double.tryParse(text);
                  if (converted != null) {
                    setState(() => discountPercentage = converted);
                  } else {
                    setState(() => discountPercentage = 0);
                  }
                },
              ),

              const SizedBox(
                height: 24,
              ),

              CustomTextfield(
                screenWidth: 80,
                borderRadius: 36,
                keyboardType: const TextInputType.numberWithOptions(),
                prefixIcon: Icon(
                  Icons.numbers_rounded,
                  color: CartifyColors.royalBlue.withAlpha(200),
                ),
                hintStyle: const TextStyle(fontSize: 14),
                hint: "How many units are available?",
                onchanged: (text) {
                  final converted = int.tryParse(text);
                  if (converted != null) {
                    setState(() => units = converted);
                  } else {
                    setState(() => units = 1);
                  }
                },
              ),

              GestureDetector(
                onTap: () async {
                  if (context.mounted) showDialog(context: context, builder: (context) => const LoadingDialog());
                  XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);
                  if (context.mounted) Navigator.pop(context);
                  if (selectedImage != null) setState(() => imageFile = File(selectedImage.path));
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 36, bottom: 8),
                  width: screenWidth * 0.5,
                  height: screenWidth * 0.5,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    color: CartifyColors.royalBlue.withAlpha(75),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: imageFile != null
                      ? Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: ConstantWidgets.text(context, "Add an image ", fontSize: 14, fontWeight: FontWeight.bold, color: CartifyColors.royalBlue)),
                ),
              ),

              Visibility(
                  visible: imageFile != null,
                  maintainSize: false,
                  child: TextButton(
                      onPressed: () => setState(() => imageFile = null),
                      child: ConstantWidgets.text(context, "Remove image", color: Colors.red, fontWeight: FontWeight.bold))),

              const SizedBox(
                height: 48,
              ),

              // Button to "Upload Product"
              CustomElevatedButton(
                  label: "Add Product",
                  screenWidth: 90,
                  textSize: 14,
                  onClick: () {
                    uploadAction(
                        productName: productName,
                        imageFile: imageFile,
                        productDetails: productDetails,
                        productPrice: productPrice,
                        category: category,
                        units: units,
                        discountPercentage: discountPercentage);
                  }),

              const SizedBox(
                height: 36,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> uploadAction({
    required String productName,
    required File? imageFile,
    required String productDetails,
    required int productPrice,
    required String category,
    required int units,
    required double discountPercentage,
  }) async {
    if (productName.length < 2) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "Kindly input the valid Product Name");
      return false;
    }

    if (imageFile == null) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "Please select an Image to upload");
      return false;
    }

    if (productDetails.length < 10) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "Describe your product in the Description box");
      return false;
    }

    if (category.length < 2) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "Select a category of your product or add custom category");
      return false;
    }

    if (units < 1) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "How many units are available in stock?");
      return false;
    }

    if (context.mounted) showDialog(context: context, builder: (context) => const LoadingDialog());

    // Call the upload function
    final String? result = await productServices.uploadProduct(
      productName: productName,
      imageFile: imageFile,
      productDetails: productDetails,
      productPrice: productPrice,
      category: category,
      units: units,
      discountPercentage: discountPercentage,
    );

    if (result == null) {
      debugPrint("Product uploaded successfully");
      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        DeviceUtils.showFlushBar(context, "Product uploaded successfully");
      }
    } else if (result == 'not-vendor') {
      debugPrint(result);
      if (mounted) {
        Navigator.pop(context);
        DeviceUtils.showFlushBar(context, "Not yet a vendor!");
        DeviceUtils.pushMaterialPage(context, const UpdateRole());
      }
    } else {
      debugPrint(result);
      if (mounted) {
        Navigator.pop(context);
        DeviceUtils.showFlushBar(context, result);
      }
    }

    return result == null;
  }
}

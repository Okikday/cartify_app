import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/app.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/styles/colors.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/data/storage/product_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:cartify/services/product_services.dart';
import 'package:cartify/services/vendor_services.dart';
import 'package:cartify/states/simple_widget_states.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/utils/formatter.dart';
import 'package:cartify/utils/utilities_functions.dart';
import 'package:cartify/views/page_elements/loading_dialog.dart';
import 'package:cartify/views/page_elements/loading_shimmer.dart';
import 'package:cartify/views/pages/elements/custom_dropdown_menu.dart';
import 'package:cartify/views/pages/elements/custom_overlay.dart';
import 'package:cartify/views/pages/elements/image_interactive_view.dart';
import 'package:cartify/views/pages/pages/update_role.dart';
import 'package:cartify/views/pages/tabs/manage_products_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProduct extends ConsumerStatefulWidget {
  final String productId;
  const UpdateProduct({super.key, required this.productId});

  @override
  ConsumerState<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends ConsumerState<UpdateProduct> {
  // TextEditingControllers for each text field
  final TextEditingController productNameTextEditingController = TextEditingController();
  final TextEditingController productDetailsTextEditingController = TextEditingController();
  final TextEditingController productPriceTextEditingController = TextEditingController();
  final TextEditingController discountTextEditingController = TextEditingController();
  final TextEditingController unitsTextEditingController = TextEditingController();

  ProductModel? product;
  String productName = "";
  String productDetails = "";
  int productPrice = 0;
  String category = ProductData.categories.first;
  double discountPercentage = 0;
  int units = 1;
  List<File>? imageFiles;
  List<String>? onlineImages;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadProduct();
    });
  }

  @override
  void dispose() {
    // TextEditingController automatically disposed in CustomTextField
    super.dispose();
  }

  loadProduct() async {
    if (mounted) {
      showDialog(
          context: context,
          builder: (context) => const LoadingDialog(
                msg: "Looking for product...",
              ));
    }
    product = await productServices.getProductByID(id: widget.productId);
    setState(() => product);
    if (product != null) {
      setState(() {
        productName = product!.name;
        productDetails = product!.productDetails;
        productPrice = product!.price.toInt();
        category = product!.category;
        discountPercentage = product!.discountPercentage;
        units = product!.units;
        onlineImages = product!.photo.map((element) => element.toString()).toList();
      });

      productNameTextEditingController.text = productName;
      productDetailsTextEditingController.text = productDetails;
      productPriceTextEditingController.text = Formatter.parsePrice(product!.price, asInt: true);
      discountTextEditingController.text = discountPercentage.truncate().toString();
      unitsTextEditingController.text = units.toString();
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return PopScope(
      canPop: ref.watch(simpleWidgetProvider).isProductInfoImageTabVisible == false,
      onPopInvokedWithResult: (didPop, result) {
        if (ref.watch(simpleWidgetProvider).isProductInfoImageTabVisible == true) {
          ref.read(simpleWidgetProvider).reverseImageInteractiveAnimController(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: ConstantWidgets.text(context, "Update product", fontSize: 14, fontWeight: FontWeight.bold),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 24),

                onlineImages != null && onlineImages!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < onlineImages!.length; i++)
                            GestureDetector(
                              onTap: () {
                                ref.refresh(simpleWidgetProvider).isProductInfoImageTabVisible = true;
                                CustomOverlay(context).showOverlay(child: ImageInteractiveView(assetName: onlineImages![i]));
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: screenWidth * 0.25,
                                height: screenWidth * 0.25,
                                child: CachedNetworkImage(
                                  imageUrl: onlineImages![i],
                                  placeholder: (context, url) {
                                    return LoadingShimmer(
                                      width: screenWidth * 0.25,
                                      height: screenWidth * 0.25,
                                    );
                                  },
                                  errorWidget: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.error,
                                        size: 64,
                                      ),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                        ],
                      )
                    : const SizedBox(
                        height: 12,
                      ),

                const SizedBox(
                  height: 12,
                ),

                CustomTextfield(
                  screenWidth: 80,
                  borderRadius: 14,
                  controller: productNameTextEditingController,
                  prefixIcon: Icon(
                    Icons.abc,
                    color: CartifyColors.royalBlue.withAlpha(200),
                  ),
                  hintStyle: const TextStyle(fontSize: 15),
                  hint: "Enter the product name",
                  onchanged: (text) => setState(() => productName = text),
                ),

                const SizedBox(height: 36),

                CustomTextfield(
                  screenWidth: 80,
                  borderRadius: 12,
                  maxLines: 8,
                  pixelHeight: 200,
                  backgroundColor: CartifyColors.royalBlue.withAlpha(25),
                  contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
                  hintStyle: const TextStyle(fontSize: 15),
                  hint: "Enter the product Description",
                  controller: productDetailsTextEditingController,
                  onchanged: (text) => setState(() => productDetails = text),
                ),

                const SizedBox(height: 36),

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
                  initialSelection: category,
                ),

                const SizedBox(height: 36),

                CustomTextfield(
                  screenWidth: 80,
                  borderRadius: 36,
                  keyboardType: const TextInputType.numberWithOptions(),
                  prefixIcon: Icon(
                    Icons.monetization_on_outlined,
                    color: CartifyColors.royalBlue.withAlpha(200),
                  ),
                  hintStyle: const TextStyle(fontSize: 14),
                  controller: productPriceTextEditingController,
                  hint: "Enter the price of the product",
                  onchanged: (text) {
                    // Remove commas and periods from the input to ensure it's parsed as an integer
                    String cleanedText = text.replaceAll(',', '').replaceAll('.', '');

                    // Ensure the text isn't empty before parsing
                    if (cleanedText.isNotEmpty) {
                      // Parse the cleaned text to an integer
                      productPrice = int.tryParse(cleanedText) ?? 0;

                      // Format the parsed integer using the formatter
                      final String converted = Formatter.parsePrice(productPrice.toDouble(), asInt: true);

                      // Update the product price and the controller with the formatted price
                      setState(() => productPrice);
                      productPriceTextEditingController.text = converted;
                    } else {
                      // If the text is empty, set the price to 0
                      setState(() => productPrice = 0);
                      productPriceTextEditingController.text = '';
                    }
                  },
                ),

                const SizedBox(height: 36),

                CustomTextfield(
                  screenWidth: 80,
                  borderRadius: 36,
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(
                    Icons.percent,
                    color: CartifyColors.royalBlue.withAlpha(200),
                  ),
                  hintStyle: const TextStyle(fontSize: 14),
                  controller: discountTextEditingController,
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

                const SizedBox(height: 24),

                CustomTextfield(
                  screenWidth: 80,
                  borderRadius: 36,
                  keyboardType: const TextInputType.numberWithOptions(),
                  prefixIcon: Icon(
                    Icons.numbers_rounded,
                    color: CartifyColors.royalBlue.withAlpha(200),
                  ),
                  hintStyle: const TextStyle(fontSize: 14),
                  controller: unitsTextEditingController,
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

                (imageFiles != null && imageFiles!.isNotEmpty
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 0; i < imageFiles!.length; i++)
                            GestureDetector(
                              onTap: () {
                                ref.refresh(simpleWidgetProvider).isProductInfoImageTabVisible = true;
                                CustomOverlay(context).showOverlay(
                                    child: ImageInteractiveView(
                                  assetName: "",
                                  assetFile: imageFiles![i],
                                ));
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                margin: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                width: screenWidth * 0.25,
                                height: screenWidth * 0.25,
                                child: Image.file(
                                  imageFiles![i],
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Icon(
                                        Icons.error,
                                        size: 64,
                                      ),
                                    );
                                  },
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          if (context.mounted) showDialog(context: context, builder: (context) => const LoadingDialog());

                          List<XFile>? selectedImages = await picker.pickMultiImage(limit: 3);

                          if (context.mounted) Navigator.pop(context);
                          if (selectedImages.length > 3 && selectedImages.isNotEmpty) {
                            selectedImages = selectedImages.sublist(0, 3);
                            if (context.mounted) DeviceUtils.showFlushBar(context, "Reduced images to three due to limit", duration: 750);
                            setState(() => selectedImages);
                          }

                          if (selectedImages.isNotEmpty) {
                            final processedImages = await Future.wait(selectedImages.map((image) async {
                              File file = File(image.path);
                              if (await file.length() <= pow(1024, 2).truncate()) {
                                return file;
                              } else {
                                return await UtilitiesFunctions.compressImageTo1MB(file);
                              }
                            }));

                            setState(() {
                              imageFiles = processedImages.whereType<File>().toList();
                            });
                          }
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
                          child: Center(
                              child:
                                  ConstantWidgets.text(context, "Replace images", fontSize: 14, fontWeight: FontWeight.bold, color: CartifyColors.royalBlue)),
                        ),
                      )),

                Visibility(
                    visible: (imageFiles != null && imageFiles!.isNotEmpty),
                    maintainSize: false,
                    child: GestureDetector(
                        onTap: () => DeviceUtils.showFlushBar(context, "Double tap to remove images", duration: 1000),
                        onDoubleTap: () {
                          setState(() => imageFiles = null);
                        },
                        child: ConstantWidgets.text(context, "Remove images", color: Colors.red, fontWeight: FontWeight.bold))),

                const SizedBox(
                  height: 48,
                ),

                // Button to "Upload Product"
                CustomElevatedButton(
                    label: "Update Product",
                    screenWidth: 90,
                    textSize: 14,
                    onClick: () {
                      updateAction(
                          productId: widget.productId,
                          productName: productName,
                          imageFiles: imageFiles,
                          productDetails: productDetails,
                          productPrice: productPrice,
                          category: category,
                          units: units,
                          discountPercentage: discountPercentage);
                      ref.refresh(vendorProductsFutureProvider);
                    }),

                const SizedBox(
                  height: 24,
                ),

                // Button to "delete Product"
                CustomElevatedButton(
                    label: "Remove Product",
                    screenWidth: 90,
                    backgroundColor: Colors.red,
                    textSize: 14,
                    onClick: () async {
                      if (context.mounted) {
                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: AlertDialog(
                                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                    title: ConstantWidgets.text(context, "Remove Product"),
                                    content: ConstantWidgets.text(context, "Are you sure you want to remove product?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: ConstantWidgets.text(context, "Go back"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (context.mounted) Navigator.pop(context);
                                          if (context.mounted) showDialog(context: context, builder: (context) => const LoadingDialog());
                                          final String? outcome = await vendorServices.deleteVendorProducts(productId: widget.productId);
                                          if (context.mounted) Navigator.pop(context);
                                          if (context.mounted) Navigator.pop(context);
                                          if (outcome == null) {
                                            if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, "Successfully deleted Product");
                                          } else {
                                            if (globalNavKey.currentContext!.mounted) DeviceUtils.showFlushBar(globalNavKey.currentContext!, outcome);
                                          }
                                          ref.refresh(vendorProductsFutureProvider);
                                        },
                                        child: ConstantWidgets.text(context, "Remove", color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ));
                      }
                    }),
                const SizedBox(
                  height: 36,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> updateAction({
    required String productId,
    required String productName,
    required List<File>? imageFiles,
    required String productDetails,
    required int productPrice,
    required String category,
    required int units,
    required double discountPercentage,
  }) async {
    if (productName.length < 2) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "Input a valid Product Name");
      return false;
    }

    if (imageFiles == null || imageFiles.isEmpty) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "Please select an Image to upload");
      return false;
    }

    if (imageFiles.length >= 4) {
      if (context.mounted) DeviceUtils.showFlushBar(context, "Remove images and select only three images");
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
    final String? result = await vendorServices.updateProduct(
      productId: productId,
      productName: productName,
      imageFiles: imageFiles,
      productDetails: productDetails,
      productPrice: productPrice,
      category: category,
      units: units,
      discountPercentage: discountPercentage,
    );

    if (result == null) {
      debugPrint("Product updated successfully");
      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        DeviceUtils.showFlushBar(context, "Product updated successfully");
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

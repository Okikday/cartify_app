import 'dart:io';  // Required for handling files
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/data/private_storage/user_data.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cartify/services/product_services.dart';  // Assuming you have this service class

class UploadProduct extends ConsumerStatefulWidget {
  const UploadProduct({super.key});

  @override
  ConsumerState<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends ConsumerState<UploadProduct> {
  String productName = "";
  File? imageFile;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Upload Product'),),
      body: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Center(
              child: CustomTextfield(
                pixelWidth: 300,
                hint: "Input the product name",
                onchanged: (text) {
                  setState(() => productName = text);
                },
              ),
            ),
            const SizedBox(height: 24,),

            Center(
              child: CustomElevatedButton(
                backgroundColor: Colors.lightBlue,
                label: imageFile == null ? "Select Image" : "Image Selected: ${imageFile!.path.split('/').last}",
                textSize: 14,
                onClick: () async {
                  // Open the image picker dialog
                  XFile? selectedImage = await _picker.pickImage(source: ImageSource.gallery);

                  if (selectedImage != null) {
                    setState(() {
                      imageFile = File(selectedImage.path);  // Save the selected image file
                    });
                  }
                },
              ),
            ),

            const SizedBox(height: 48,),

            // Button to "Upload Product"
            Center(
              child: CustomElevatedButton(
                label: "Upload Product",
                textSize: 14,
                onClick: () async {

                  if (imageFile != null && productName.isNotEmpty && productName.length > 2) {

                    final String? apiKey = await UserData().getUserApiKey();

                    // Call the upload function
                    String? result;
                    if(apiKey != null){
                      result = await ProductServices().uploadProduct(
                      apiKey: apiKey,
                      productName: productName,
                      imageFile: imageFile!,
                    );
                    }

                    if (result == null) {
                      debugPrint("Product uploaded successfully");
                      if(context.mounted) DeviceUtils.showFlushBar(context, "Product uploaded successfully");
                    } else {
                      debugPrint("Failed to upload product: $result");
                      if(context.mounted) DeviceUtils.showFlushBar(context, "Failed to upload product: $result");
                    }
                  } else {
                    debugPrint("Please enter a product name and select an image.");
                    if(context.mounted) DeviceUtils.showFlushBar(context, "Please enter a product name and select an image.");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

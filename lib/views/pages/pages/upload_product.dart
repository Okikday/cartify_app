import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadProduct extends ConsumerStatefulWidget {
  const UploadProduct({super.key});

  @override
  ConsumerState<UploadProduct> createState() => _UploadProductState();
}

class _UploadProductState extends ConsumerState<UploadProduct> {
  String productName = "";

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Upload Product'),),
      body: Column(
        children: [
          CustomTextfield(
            hint: "Input the product name",
            onchanged: (text){
              setState(() => productName = text);
          },),

          CustomElevatedButton(label: "Upload Product", textSize: 14, )
        ],
      ),
    );
  }
}


import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/common/widgets/custom_elevated_button.dart';
import 'package:cartify/common/widgets/custom_textfield.dart';
import 'package:cartify/services/user_services.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/page_elements/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateRole extends ConsumerStatefulWidget {
  const UpdateRole({super.key});

  @override
  ConsumerState<UpdateRole> createState() => _UpdateRoleState();
}

class _UpdateRoleState extends ConsumerState<UpdateRole> {
  final UserServices userServices = UserServices();
  String addressText = '';
  String phoneNumber = "";

  @override
  Widget build(BuildContext context,) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Turn a vendor"),),

      body: Column(
        children: [
          Center(child: ConstantWidgets.text(context, "Make Yourself a vendor to upload products")),
          const SizedBox(height: 24,),
          Center(
              child: CustomTextfield(
                pixelWidth: 300,
                keyboardType: TextInputType.streetAddress,
                hint: "Enter your address",
                onchanged: (text) {
                  setState(() => addressText = text);
                },
              ),
            ),

            const SizedBox(height: 24,),

            Center(
              child: CustomTextfield(
                keyboardType: TextInputType.phone,
                pixelWidth: 300,
                hint: "Enter your Phone number",
                onchanged: (text) {
                  setState(() => phoneNumber = text);
                },
              ),
            ),

            const SizedBox(height: 24,),

            Center(child: CustomElevatedButton(label: "Continue", textSize: 14, onClick: () async{
              if(context.mounted){
                showDialog(context: context, builder: (context) => const LoadingDialog());
              }
              final updateRoleOutcome = await userServices.updateUserRole(enableToVendor: true, phoneNumber: phoneNumber, address: addressText);
              debugPrint(updateRoleOutcome.toString());
              if(updateRoleOutcome == null){
                if(context.mounted){
                  Navigator.pop(context);
                  Navigator.pop(context);
                  DeviceUtils.showFlushBar(context, "Successfully updated user role");
                }
              }else{
                if(context.mounted){
                  Navigator.pop(context);
                  DeviceUtils.showFlushBar(context, updateRoleOutcome);
                }
              }
            },)),

        ],
      ),
    );
  }
}
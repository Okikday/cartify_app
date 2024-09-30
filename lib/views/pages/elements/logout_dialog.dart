import 'package:cartify/app.dart';
import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/services/auth/user_auth.dart';
import 'package:cartify/utils/device_utils.dart';
import 'package:cartify/views/authentication/sign_in.dart';
import 'package:cartify/views/page_elements/loading_dialog.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: ConstantWidgets.text(context, "Confirm Logout"),
      content: ConstantWidgets.text(context, "Are you sure you want to logout?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: ConstantWidgets.text(context, "Cancel"),
        ),
        ElevatedButton(
          
          onPressed: () async {
            if (context.mounted) Navigator.pop(context);
            if (globalNavKey.currentContext!.mounted) showDialog(context: globalNavKey.currentContext!, builder: (context) => const LoadingDialog());
            final UserAuth userAuth = UserAuth();
            final String? signOut = await userAuth.googleSignOut();
            if (globalNavKey.currentContext!.mounted) signOut != null ? DeviceUtils.showFlushBar(globalNavKey.currentContext!, signOut) : () {};
            if (signOut == null) Navigator.pushReplacement(globalNavKey.currentContext!, MaterialPageRoute(builder: (context) => const SignIn()));
          },
          child: ConstantWidgets.text(context, "Logout", color: Colors.red),
        ),
      ],
    );
  }
}

import 'package:cartify/common/constants/constant_widgets.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/data/storage/preferences_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  final HiveData hiveData = HiveData();
  bool? darkMode;

  @override
  void initState() {
    super.initState();
    loadSettings();

  }

  loadSettings() async{
    final bool? loadDarkMode = await hiveData.getData(key: "settings_darkMode");
    setState(() {
      darkMode = loadDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
       
      body: Column(
        children: [
          Container(
              height: screenHeight * 0.07,
              width: screenWidth,
              margin: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: kToolbarHeight,
              ),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ConstantWidgets.text(context, "Settings", fontSize: 20, fontWeight: FontWeight.bold),
            ),

            ListTile(leading: ConstantWidgets.text(context, "Dark mode", fontSize: 16), trailing: Switch(value: darkMode ?? PreferencesData.darkMode, onChanged: (value){
              darkMode = value;
            }), style: ListTileStyle.list,),
        ],
      ),
    );
  }
}
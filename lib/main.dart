import 'package:cartify/app.dart';
import 'package:cartify/data/hive_data/hive_data.dart';
import 'package:cartify/models/products_models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Hive.initFlutter();
  await HiveData.initHiveData();
  final hiveData = HiveData();
  await hiveData.initSecureHiveData();
  Hive.registerAdapter(ProductModelAdapter());
  
  runApp(const ProviderScope(child: App()));
  
}
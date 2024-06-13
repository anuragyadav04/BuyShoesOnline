import 'package:buy_shoes_online/controller/home_controller.dart';
import 'package:buy_shoes_online/firebase_options.dart';
import 'package:buy_shoes_online/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart'; // Import firebase_core
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);

  ///? registering my controller
  Get.put(HomeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Footware Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

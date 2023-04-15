import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:my_gallery/modules/home_gallery/presentation/screens/home_gallery.dart';
import 'package:my_gallery/shared/local/shared_prefrence.dart';
import 'package:my_gallery/shared/network/dio_helper.dart';

import 'modules/login/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyGallerySharedPreferences.init();
  DioHelper.init();
  final bool? isLoginSuccess = MyGallerySharedPreferences.get("isLoginSuccess");
  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(
      isLoginSuccess: isLoginSuccess ?? false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.isLoginSuccess = false});

  final bool isLoginSuccess;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: isLoginSuccess ? HomeGallery() : LoginScreen(),
    );
  }
}

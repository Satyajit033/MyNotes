import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/application/controller_binding.dart';
import 'package:my_notes/presentation/ui/screen/splash_screen.dart';

class MyNotes extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();
  const MyNotes({super.key});

  @override
  State<MyNotes> createState() => _MyNotesState();
}

class _MyNotesState extends State<MyNotes> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      title: "My Notes",
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialBinding: ControllerBinding(),
      navigatorKey: MyNotes.globalKey,
    );
  }
}
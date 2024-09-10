import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_notes/data/utility/auth_utility.dart';
import 'package:my_notes/presentation/ui/screen/home_screen.dart';
import 'package:my_notes/presentation/ui/screen/auth/login_screen.dart';
import 'package:my_notes/presentation/ui/utility/style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  void navigateToLogin() {
    Future.delayed(const Duration(seconds: 3)).then((_) async {
      final bool isLoggedIn = await AuthUtility.checkIfUserLoggedIn();
      if (mounted) {
        Get.offAll(
              () => isLoggedIn ? const HomeScreen() : const LoginScreen(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            const Spacer(),
            Center(
              child: SvgPicture.asset(
                "assets/images/logo.svg",
                width: 150,
              ),
           /*   SvgPicture.asset(
                AssetsUtils.logoSVG,
                width: 100,
              ),*/
            ),
            const Spacer(),
            const CircularProgressIndicator(color: colorDarkBlue,),
            const SizedBox(
              height: 16,
            ),
            const Text("Version 1.0"),
            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
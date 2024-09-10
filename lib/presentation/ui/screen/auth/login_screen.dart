import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/presentation/ui/screen/home_screen.dart';
import 'package:my_notes/presentation/state_holders/login_controller.dart';
import 'package:my_notes/presentation/ui/screen/auth/sign_up_screen.dart';
import 'package:my_notes/presentation/ui/utility/style.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome", style: Head1Text(colorDarkBlue)),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _emailTEController,
                        decoration: AppInputDecoration("Email"),
                        cursorColor: colorDarkBlue,
                        validator: (String? text) {
                          if (text?.isEmpty ?? true) {
                            return 'Enter your email address';
                          } else if (text!.isEmail == false) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordTEController,
                        obscureText: true,
                        decoration: AppInputDecoration("Password"),
                        cursorColor: colorDarkBlue,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<LoginController>(builder: (loginController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: loginController.loginInProgress == false,
                            replacement: const Center(
                              child: CircularProgressIndicator(
                                color: colorDarkBlue,
                              ),
                            ),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  loginController.login(_emailTEController.text.trim(),
                                      _passwordTEController.text)
                                      .then((value) {
                                    if (value) {
                                      SuccessToast("Login Success");
                                      Get.offAll(() => const HomeScreen());
                                    } else {
                                      ErrorToast("Login Failed");
                                    }
                                  });
                                },
                                style: AppButtonStyle(),
                                child: SuccessButtonChild(const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: colorDarkBlue,
                                )),
                          ),
                          )
                        );
                      }),
                      const SizedBox(
                        height: 45,
                      ),
                      InkWell(
                          onTap: (){
                            Get.to(() => const SignUpScreen());
                          },
                          child:Center(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontSize: 14.0,
                                    color: Colors.black,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Don't have an account?",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: colorDarkBlue)),
                                    TextSpan(
                                        text: '  Sign Up',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.amber)),
                                  ],
                                ),
                              )
                          )
                      )
                    ],
                  ),
                ),
              ),
          ),
        ),
        );
  }
}

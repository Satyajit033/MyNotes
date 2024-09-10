import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_notes/presentation/state_holders/sign_up_controller.dart';
import 'package:my_notes/presentation/ui/utility/style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      Text("Sign Up", style: Head1Text(colorDarkBlue)),
                      const SizedBox(
                        height: 20,
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
                        controller: _firstNameTEController,
                        decoration: AppInputDecoration("First Name"),
                        cursorColor: colorDarkBlue,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your first name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                      controller: _lastNameTEController,
                        decoration: AppInputDecoration("Last Name"),
                        cursorColor: colorDarkBlue,
                        validator: (String? value) {
                          if (value?.isEmpty ?? true) {
                            return 'Enter your last name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                       controller: _mobileTEController,
                        decoration: AppInputDecoration("Mobile"),
                        cursorColor: colorDarkBlue,
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length < 11) {
                            return 'Enter your valid mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        obscureText: true,
                      controller: _passwordTEController,
                        decoration: AppInputDecoration("Password"),
                        cursorColor: colorDarkBlue,
                        validator: (String? value) {
                          if ((value?.isEmpty ?? true) || value!.length <= 5) {
                            return 'Enter a password more than 6 letters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<SignupController>(builder: (signupController) {
                        return SizedBox(
                          width: double.infinity,
                          child: Visibility(
                            visible: signupController.signUpInProgress == false,
                            replacement:
                            const Center(child: CircularProgressIndicator(
                              color: colorDarkBlue,
                            )),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  signupController.userSignUp(
                                      _emailTEController.text.trim(),
                                      _firstNameTEController.text.trim(),
                                      _lastNameTEController.text.trim(),
                                      _mobileTEController.text.trim(),
                                      _passwordTEController.text)
                                      .then((value) {
                                    if (value) {
                                      _emailTEController.clear();
                                      _passwordTEController.clear();
                                      _firstNameTEController.clear();
                                      _lastNameTEController.clear();
                                      _mobileTEController.clear();
                                     SuccessToast("Registration Success");
                                     Get.back();
                                    } else {
                                     ErrorToast("Registration Failed..!");
                                    }
                                  });
                                },
                                style: AppButtonStyle(),
                                child: SuccessButtonChild(const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: colorDarkBlue,
                                  )
                                ),
                              ),
                           )
                        );
                      }),
                      const SizedBox(
                        height: 45,
                      ),
                      InkWell(
                        onTap: (){
                         Get.back();
                        },
                        child: Center(
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: 'poppins',
                                  fontSize: 14.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: "Have account?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: colorDarkBlue)),
                                  TextSpan(
                                      text: '  Sign In',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold, color: Colors.amber)),
                                ],
                              ),
                            )
                        ),
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

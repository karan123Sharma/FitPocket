import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'core/component/app_text_field.dart';
import 'core/route/app_route_name.dart';
import 'core/theme/app_color.dart';

class LoginScreen extends StatelessWidget { LoginScreen({super.key});

  @override

  final _emailcontroller =TextEditingController();
  final _passwordcontroller =TextEditingController();
  Future signin() async{
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim()
    );
  }

  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
              bottom: MediaQuery.of(context).padding.bottom,
              left: 24,
              right: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  width: MediaQuery.of(context).size.width,
                  height: 250,
                  fit: BoxFit.contain,
                  image: const AssetImage("assets/img_login.png"),
                ),
                Text(
                  "Login",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppTextField(
                      controller: _emailcontroller,
                      prefix: Icon(Icons.alternate_email_rounded),
                      hint: "Email Address",

                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: 24),
                    AppTextField(
                      controller: _passwordcontroller,
                      obscureText: true,
                      prefix: Icon(Icons.lock_outline_rounded),
                      suffix: Icon(Icons.remove_red_eye_outlined),
                      hint: "Password",

                      textInputAction: TextInputAction.done,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        AppRouteName.forgotPassword,
                      );
                    },
                    child: const Text("Forgot Password ?"),
                  ),
                ),
                     SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {
                        signin();

                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: signin,
                          child: Text("Login")
                      ),
                    ),
                  ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Text("OR"),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 64,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    icon: const Image(
                      image: AssetImage("assets/ic_google.png"),
                      width: 32,
                      height: 32,
                    ),
                    label: const Text("Login with Google"),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Don't have an Account ? ",
                          style: Theme.of(context).textTheme.button,
                        ),
                        TextSpan(
                          text: "Register here!",
                          style: Theme.of(context)
                              .textTheme
                              .button
                              ?.copyWith(color: AppColor.primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                context,
                                AppRouteName.register,
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}

import 'package:digifarmer/services/auth_service.dart';
import 'package:digifarmer/widgets/my_button.dart';
import 'package:digifarmer/widgets/my_text_field.dart';
import 'package:digifarmer/widgets/squre_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
//text editing controllers
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

// sign user in method
  void signIn() async {
    FocusScope.of(context).unfocus();
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: Colors.blue[300]!,
              ),
            ));
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      // if (!context.mounted) return;
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'invalid-email') {
        // Wrong Email
        wrongCredentialMessage('Invalid Email');
      } else if (e.code == 'invalid-credential') {
        wrongCredentialMessage('Invalid Password');
      }

      //         ));
    }
  }

  void wrongCredentialMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(message),
              content: message == 'Invalid Email'
                  ? const Text('Please enter a valid email')
                  : const Text('Please enter a valid password'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.grey[800]),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  //logo
                  Icon(
                    Icons.lock,
                    size: 100.sp,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  //welcome text
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),

                  //text fields
                  MyTextField(
                    isPasswordTextField: false,
                    hintText: 'Username',
                    controller: usernameController,
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  MyTextField(
                    isPasswordTextField: true,
                    hintText: 'Password',
                    controller: passwordController,
                  ),
                  //forgot password
                  SizedBox(
                    height: 8.h,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  //login button
                  MyButton(
                    text: 'Sign In',
                    ontap: signIn,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  //google + apple sign in
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(
                          onTap: () {
                            AuthService().signInWithGoogle();
                          },
                          imgUrl: 'assets/images/auth/google.png'),
                      SizedBox(
                        width: 20.w,
                      ),
                      SquareTile(
                          onTap: () {}, imgUrl: 'assets/images/auth/apple.png'),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  //not a member? sign up
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey),
                    ),
                    TextButton(
                      onPressed: widget.onTap,
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ])
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
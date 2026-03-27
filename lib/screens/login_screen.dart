import 'package:ecommerce_app/models/form_field_model.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/widgets/custom_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  final AuthService authService = AuthService();

  Future<void> onLoginSubmit() async {
    if (loginFormKey.currentState!.validate()) {
      try {
        final response = await authService.login(
          usernameController.text,
          passwordController.text,
        );
        if (!mounted) return;
        if (response) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Logged in Successfully')));
          context.goNamed('home');
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.2,
                          color: Color(0xFFDDDDDD),
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            if (context.canPop()) {
                              context.pop();
                            } else {
                              context.goNamed('/');
                            }
                          },
                          icon: Icon(Icons.chevron_left),
                          iconSize: 30.r,
                        ),
                      ),
                    ),
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 45.w),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        'HamroMart',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 25.h),
                    Form(
                      key: loginFormKey,
                      child: Column(
                        children: [
                          customFormField(
                            FormFieldModel(
                              controller: usernameController,
                              label: 'Username',
                              hintText: 'Username',
                              validationFn: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Username Required';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: 15.h),
                          customFormField(
                            FormFieldModel(
                              controller: passwordController,
                              label: 'Password',
                              hintText: 'Password',
                              validationFn: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password Required';
                                }
                                if (value.length < 8) {
                                  return 'Password must contain atleast 8 characters';
                                }
                                return null;
                              },
                              obscureText: showPassword,
                              toggleObscureText: () {
                                setState(() => showPassword = !showPassword);
                              },
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Color.fromARGB(255, 139, 139, 139),
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ],
                          ),
                          SizedBox(height: 30.h),
                          ConstrainedBox(
                            constraints: BoxConstraints(minWidth: 120.w),
                            child: FilledButton(
                              onPressed: onLoginSubmit,
                              style: FilledButton.styleFrom(
                                shape: StadiumBorder(),
                                backgroundColor: Color(0xff121111),
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.r,
                                  horizontal: 20.r,
                                ),
                              ),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 5.r,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(fontSize: 16.sp),
                    ),
                    Text(
                      "Sign up here",
                      style: TextStyle(
                        color: Colors.blue[900],
                        fontSize: 16.sp,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

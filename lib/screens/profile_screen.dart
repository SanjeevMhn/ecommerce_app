import 'package:ecommerce_app/controllers/auth_controller.dart';
import 'package:ecommerce_app/helpers/app_helpers.dart';
import 'package:ecommerce_app/services/auth_service.dart';
import 'package:ecommerce_app/widgets/unauthenticated_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';

class ProfileMenuModel {
  final String name;
  final IconData icon;
  final VoidCallback onPressed;

  ProfileMenuModel({
    required this.name,
    required this.icon,
    required this.onPressed,
  });
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  final AuthService authService = AuthService();
  final box = GetStorage();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final List<ProfileMenuModel> menus = [
      ProfileMenuModel(
        name: 'My Orders',
        icon: Icons.shopping_cart,
        onPressed: () {},
      ),
      ProfileMenuModel(
        name: 'Delivery Address',
        icon: Icons.location_on,
        onPressed: () {},
      ),
      ProfileMenuModel(name: 'Contact Us', icon: Icons.call, onPressed: () {}),
      ProfileMenuModel(name: 'Help & FAQs', icon: Icons.note, onPressed: () {}),
      ProfileMenuModel(
        name: 'Settings',
        icon: Icons.settings,
        onPressed: () {},
      ),
      ProfileMenuModel(
        name: 'Logout',
        icon: Icons.logout,
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Logout?'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      authController.logout();
                      context.goNamed('home');
                      Navigator.of(context).pop();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              );
            },
          );
        },
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  final isLoggedIn = authController.isLoggedIn.value;
                  if (!isLoggedIn) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 250,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [UnauthenticatedDisplay()],
                      ),
                    );
                  }
                  return box.read('user') != null
                      ? Column(
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 50.r),
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 80.r,
                                      child: Image.network(
                                        box.read('user')['image'],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15.h),
                                Text(
                                  AppHelpers.capitalize(
                                    box.read('user')['username'],
                                  ),
                                  style: TextStyle(fontSize: 22.sp),
                                ),

                                Text(
                                  box.read('user')['email'],
                                  style: TextStyle(fontSize: 15.sp),
                                ),
                              ],
                            ),
                            SizedBox(height: 30.h),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final item = menus[index];
                                return ListTile(
                                  onTap: item.onPressed,
                                  title: Text(item.name),
                                  leading: CircleAvatar(
                                    backgroundColor: Color(0xFF121111),
                                    child: Icon(item.icon, color: Colors.white),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.5.r),
                                child: Divider(
                                  thickness: 1.2,
                                  color: Color(0xFF121111),
                                ),
                              ),
                              itemCount: menus.length,
                            ),
                          ],
                        )
                      : SizedBox.shrink();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

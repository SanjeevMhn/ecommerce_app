import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class UnauthenticatedDisplay extends StatelessWidget {
  const UnauthenticatedDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.r,
      children: [
        Text('Hello, Welcome to HamroMart', style: TextStyle(fontSize: 20.sp)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8.r,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Color(0xFF121111)),
              onPressed: () {
                context.go('/login');
              },
              child: Text('Login', style: TextStyle(color: Colors.white)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 15.r),
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Color(0xFF121111), width: 1.5),
                borderRadius: BorderRadius.circular(100.r),
                color: Colors.white,
              ),
              child: Text('Signup'),
            ),
          ],
        ),
      ],
    );
  }
}

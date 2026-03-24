import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryButton extends StatelessWidget {
  final String category;
  final bool isActive;
  final Function(String) onCategoryClicked;
  const CategoryButton({
    super.key,
    required this.category,
    required this.isActive,
    required this.onCategoryClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () => isActive ? null : onCategoryClicked(category),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 50.w),
            child: Container(
              padding: EdgeInsets.all(5.r),
              decoration: BoxDecoration(
                border: BoxBorder.all(
                  width: 1.5,
                  color: isActive ? Color(0xFFDDDDDD) : Color(0xFF121111),
                ),
                borderRadius: BorderRadius.circular(8.r),
                color: isActive ? Color(0xFF121111) : Colors.white,
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isActive ? Colors.white : Color(0xFF121111),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
      ],
    );
  }
}

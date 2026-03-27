import 'package:ecommerce_app/models/form_field_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customFormField(FormFieldModel model) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        model.label,
        style: TextStyle(
          color: Color(0xFF121111),
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 8.h),
      TextFormField(
        controller: model.controller,
        keyboardType: model.inputType ?? TextInputType.text,
        obscureText: model.obscureText != null ? !model.obscureText! : false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.r),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: const Color(0xFFC62828), width: 1.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: const Color(0xFFC62828), width: 1.0),
          ),
          errorStyle: TextStyle(color: Colors.red[800]),
          hintText: model.hintText,
          filled: true,
          fillColor: Colors.white,
          suffixIcon: model.obscureText != null
              ? IconButton(
                  onPressed: model.toggleObscureText,
                  icon: model.obscureText!
                      ? Icon(
                          Icons.visibility_outlined,
                          size: 20.r,
                          color: Color(0xFF121111),
                        )
                      : Icon(
                          Icons.visibility_off_outlined,
                          size: 20.r,
                          color: Color(0xFF121111),
                        ),
                )
              : null,
        ),
        validator: model.validationFn,
      ),
    ],
  );
}

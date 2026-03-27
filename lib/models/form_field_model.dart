import 'package:flutter/material.dart';

class FormFieldModel {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final String? Function(String?) validationFn;
  bool? obscureText;
  void Function()? toggleObscureText;
  TextInputType? inputType;

  FormFieldModel({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.validationFn,
    this.obscureText,
    this.toggleObscureText,
    this.inputType,
  });
}

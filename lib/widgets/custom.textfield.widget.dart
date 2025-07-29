import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelTxt;
  final String hintTxt;
  final TextInputType keyboardType;
  final bool obsureText;
  final TextEditingController? controller;
  final bool isTextArea; //  Added

  const CustomTextField({
    super.key,
    required this.labelTxt,
    required this.hintTxt,
    required this.keyboardType,
    required this.obsureText,
    this.controller,
    this.isTextArea = false, //  Default to false
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final Color _focusedBorderColor = const Color.fromRGBO(74, 67, 236, 1.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelTxt,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          cursorColor: _focusedBorderColor,
          keyboardType: widget.isTextArea
              ? TextInputType.multiline
              : widget.keyboardType,
          obscureText: widget.isTextArea ? false : widget.obsureText,
          maxLines: widget.isTextArea ? 5 : 1, //TextArea behavior
          minLines: widget.isTextArea ? 3 : 1,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hintTxt,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                width: 1,
                color: _focusedBorderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: _focusedBorderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: _focusedBorderColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelTxt;
  final String hintTxt;
  final keyboardType;
  final obsureText;
  final TextEditingController ? controller;


  const CustomTextField({super.key,
    required this.labelTxt,
    required this.hintTxt,
    required this.keyboardType,
    required this.obsureText,
    this.controller});

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
        Text(widget.labelTxt, style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),),
        TextFormField(
          controller: widget.controller,
          cursorColor: _focusedBorderColor,
          keyboardType: widget.keyboardType,
          obscureText: widget.obsureText,
          style: TextStyle(
            color: Colors.black,
          ),
          decoration: InputDecoration(
              filled: true,
              hintText: widget.hintTxt,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      width: 1,
                      color: _focusedBorderColor,
                      style: BorderStyle.solid
                  )
              ),

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1,
                    color: _focusedBorderColor,
                    style: BorderStyle.solid
                )
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: _focusedBorderColor,
                      style: BorderStyle.solid
                  )
              )
          ),
        ),
        SizedBox(height: 10,),

      ],
    );
  }
}

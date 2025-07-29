import 'package:flutter/material.dart';

class CustomSelectableButtons extends StatefulWidget {
  final List<String> options;
  final Function(String)? onSelected; //  Add callback

  const CustomSelectableButtons({
    super.key,
    required this.options,
    this.onSelected,
  });

  @override
  State<CustomSelectableButtons> createState() => _CustomSelectableButtonsState();
}

class _CustomSelectableButtonsState extends State<CustomSelectableButtons> {
  String? selectedValue;

  void selectButton(String value) {
    setState(() {
      selectedValue = value;
    });
    if (widget.onSelected != null) {
      widget.onSelected!(value); //  Trigger the callback
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: widget.options.map((option) {
        bool isSelected = selectedValue == option;
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          width: 145, // Fixed width
          height: 50,
          child: GestureDetector(
            onTap: () => selectButton(option),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected ? Color.fromRGBO(74, 67, 236, 1.0) : Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isSelected ? Color.fromRGBO(74, 67, 236, 1.0) : Colors.grey,
                  width: 0,
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

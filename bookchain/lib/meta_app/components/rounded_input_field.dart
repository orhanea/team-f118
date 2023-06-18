import 'package:bookchain/meta_app/components/text_field_container.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController myController;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    super.key,
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
    required this.myController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      myController: myController,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            icon,
            color: ColorSpecs.colorInstance.kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

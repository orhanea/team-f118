import 'package:bookchain/meta_app/components/text_field_container.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatelessWidget {
  final TextEditingController myController;
  final ValueChanged<String> onChanged;
  const RoundedPasswordField({
    super.key,
    required this.onChanged,
    required this.myController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
        myController: myController,
        child: TextField(
      onChanged: onChanged,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
        icon: Icon(Icons.lock),
        suffixIcon: Icon(
          Icons.visibility,
        ),
        border: InputBorder.none,
      ),
          onSubmitted: onChanged,
    ));
  }
}

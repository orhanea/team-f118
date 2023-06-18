import 'package:flutter/material.dart';
import 'package:bookchain/meta_app/helpers/constants/colors.dart';

class TextFieldContainer extends StatelessWidget {
  final TextEditingController myController;
  final Widget child;
  const TextFieldContainer({
    super.key,
    required this.child,
    required this.myController,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5),
      width: size.width * 0.8,
      height: size.height * 0.07,
      decoration: BoxDecoration(
        color: ColorSpecs.colorInstance.kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}

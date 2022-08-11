import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/colors.dart';

class AuthTextField extends StatelessWidget {
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController textEditingController;
  const AuthTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    this.isPass = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fieldBorder = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
    );
    return TextField(
      onTap: () {},
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true,
        hintText: hintText,
        border: fieldBorder,
        focusedBorder: fieldBorder,
        enabledBorder: fieldBorder,
        contentPadding: const EdgeInsets.all(8),
      ),
      obscureText: isPass,
      keyboardType: textInputType,
    );
  }
}

class InstaLogo extends StatelessWidget {
  const InstaLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/ic_instagram.svg',
      color: primaryColor,
      height: 64,
    );
  }
}

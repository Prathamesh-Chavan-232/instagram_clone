import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/common_utils/colors.dart';

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

class SwitchAuth extends StatelessWidget {
  final String btnText;
  final String path;
  const SwitchAuth({required this.btnText, required this.path, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.popAndPushNamed(context, path);
      },
      child: Text(btnText),
    );
  }
}

Widget authButton(
    {required String btnText,
    required bool isloading,
    required Function()? onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: authButtonStyle(),
      onPressed: onPressed,
      child: isloading
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(color: primaryColor),
            )
          : Text(btnText),
    ),
  );
}

ButtonStyle authButtonStyle() {
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all(blueColor),
  );
}

Widget instaLogo() {
  return SvgPicture.asset(
    'assets/ic_instagram.svg',
    color: primaryColor,
    height: 64,
  );
}

Future displayToast(String toastMsg) async {
  await Fluttertoast.showToast(
      msg: toastMsg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withOpacity(0.6),
      textColor: Colors.white,
      fontSize: 14.0);
}

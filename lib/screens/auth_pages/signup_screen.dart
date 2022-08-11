import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/common_widgets/auth_widgets.dart';
import 'package:instagram_clone/globals.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';
import 'package:instagram_clone/utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    // App logo image
    // Email Text field
    // Password Text field
    // Forgot & Swtich to Signup
    // Login button
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        width: screenWidth,
        height: screenheight,
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const InstaLogo(),
                _selectProfilePhoto(context),
                const SizedBox(height: 24),
                _displaySignupFields(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? "),
                    _switchToLogin(context)
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Container _selectProfilePhoto(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 18),
      height: MediaQuery.of(context).size.height * 0.20,
      child: Stack(children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(DEFAULT_PROFILE_PICTURE),
          radius: 64,
        ),
        Positioned(
            bottom: -15,
            left: 80,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_a_photo),
            ))
      ]),
    );
  }

  Widget _displaySignupFields() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          AuthTextField(
            hintText: 'User name',
            textEditingController: _usernameController,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          AuthTextField(
            hintText: 'Bio',
            textEditingController: _bioController,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          AuthTextField(
            isPass: true,
            hintText: 'Email Address',
            textEditingController: _emailController,
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 24),
          AuthTextField(
            isPass: true,
            hintText: 'Password',
            textEditingController: _passController,
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 24),
          _signupBtn(btnText: 'Sign-Up')
        ],
      ),
    );
  }

  Widget _signupBtn({required String btnText}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(blueColor),
        ),
        onPressed: () async {
          User res = await AuthMethods().signUp(_usernameController.text,
              _bioController.text, _emailController.text, _passController.text);
          Navigator.popAndPushNamed(context, '/home');
        },
        child: Text(btnText),
      ),
    );
  }

  TextButton _switchToLogin(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.popAndPushNamed(context, '/login');
      },
      child: const Text('Log-in'),
    );
  }

  @override
  void dispose() {
    _bioController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}

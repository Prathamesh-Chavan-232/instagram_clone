import 'package:flutter/material.dart';
import 'package:instagram_clone/common_widgets/auth_widgets.dart';
import 'package:instagram_clone/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

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
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: screenWidth,
            minHeight: screenheight,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 4),
              const InstaLogo(),
              const Spacer(flex: 1),
              _displayLoginFields(),
              const Spacer(flex: 3),
              const Divider(thickness: 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  _switchToSignup(context)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _loginBtn({required String btnText}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(blueColor),
        ),
        onPressed: () {},
        child: Text(btnText),
      ),
    );
  }

  Widget _displayLoginFields() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        children: [
          AuthTextField(
            hintText: 'Email Address',
            textEditingController: _emailController,
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          AuthTextField(
            isPass: true,
            hintText: 'Password',
            textEditingController: _passController,
            textInputType: TextInputType.visiblePassword,
          ),
          const SizedBox(height: 24),
          _loginBtn(btnText: 'Log-in'),
        ],
      ),
    );
  }

  TextButton _switchToSignup(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.popAndPushNamed(context, '/signup');
      },
      child: const Text('Sign-up'),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}

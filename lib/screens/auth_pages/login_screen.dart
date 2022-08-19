import 'package:flutter/material.dart';
import 'package:instagram_clone/common_widgets/auth_widgets.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';
import 'package:instagram_clone/common_utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late bool isloading;

  @override
  void initState() {
    isloading = false;
    super.initState();
  }

  /* Contents -
    App logo image
    Email Text field
    Password Text field
    Forgot Password -> pending 
    Swtich to Signup
    Login button
  */
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: screenWidth,
            minHeight: screenheight,
          ),
          /* 
          Note - This Column has less content Hence Spacer() can be used without single child scroll view
                  Using Spacer causes column to shrink wrap and resize when keyboard appears.

                  This can't be done when the page has a lot of content. And Single child scroll should be used to make it into a scrollable
          */
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 4),
              instaLogo(),
              const Spacer(flex: 1),
              _displayLoginFields(),
              const Spacer(flex: 3),
              const Divider(thickness: 1.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Don't have an account? "),
                  SwitchAuth(btnText: "Sign-up", path: '/signup')
                ],
              ),
            ],
          ),
        ),
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

  Widget _loginBtn({required String btnText}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(blueColor),
        ),
        onPressed: () async {
          setState(() => isloading = true); // loading start

          // Text field validation
          if (_emailController.text.isEmpty || _passController.text.isEmpty) {
            displayToast("All fields are required");
          }

          // Proceed to login
          else {
            String res = await FireAuth().loginWithEmailAndPass(
                email: _emailController.text, password: _passController.text);

            //  Login successful
            if (res == "Success") {
              Navigator.popAndPushNamed(context, '/home');
            }
            // Display error msg
            else {
              displayToast(res);
            }
          }
          setState(() => isloading = false); // loading ends
        },
        child: isloading
            ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(color: primaryColor),
              )
            : Text(btnText),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}

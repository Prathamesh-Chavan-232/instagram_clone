import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/common_widgets/auth_widgets.dart';
import 'package:instagram_clone/globals.dart';
import 'package:instagram_clone/services/fireauth/fire_auth.dart';
import 'package:instagram_clone/common_utils/colors.dart';
import 'package:instagram_clone/common_utils/Image_picker/img_picker.dart';

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
  Uint8List? _image;

  @override
  void initState() {
    super.initState();
  }

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
                instaLogo(),
                _selectProfilePhoto(context),
                const SizedBox(height: 24),
                _displaySignupFields(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const Divider(thickness: 1.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Already have an account? "),
                    SwitchAuth(btnText: "Log-in", path: '/login')
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
        _image != null
            ? CircleAvatar(
                backgroundImage: MemoryImage(_image!),
                radius: 64,
              )
            : const CircleAvatar(
                backgroundImage: NetworkImage(DEFAULT_PROFILE_PICTURE),
                radius: 64,
              ),
        Positioned(
            bottom: -15,
            left: 80,
            child: IconButton(
              onPressed: selectImage,
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
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
          AuthTextField(
            hintText: 'Bio',
            textEditingController: _bioController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(height: 24),
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
          String res = await AuthService().signUpWithEmailAndPass(
              profilePic: _image,
              username: _usernameController.text,
              bio: _bioController.text,
              email: _emailController.text,
              password: _passController.text);
          if (res == "User Signed-in successfully") {
            displayToast(res);
            Navigator.popAndPushNamed(context, '/home');
          } else {
            displayToast(res);
          }
        },
        child: Text(btnText),
      ),
    );
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
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

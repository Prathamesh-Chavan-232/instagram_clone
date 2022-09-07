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

  late bool isloading;

  @override
  void initState() {
    isloading = false;
    super.initState();
  }

  /* Contents -
    App logo image
    Select Profile Photo - Image picker
    Username Text field
    Bio Text field
    Email Text field
    Password Text field
    Swtich to Login
    Signup button
  */

  /*
    Use Single child scroll view here since this screen has lot of content
    Add this padding on the widget that should be visible - EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
  */
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        width: screenWidth,
        height: screenheight,
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  ]),
            )),
      )),
    );
  }

  // Add action sheet
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
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
          setState(() => isloading = true); // Display the loading spinner

          // Profile photo validation
          if (_image == null) {
            displayToast("Select a Profile photo");
          }

          // Form field validation
          else if (_usernameController.text.isEmpty ||
              _passController.text.isEmpty ||
              _bioController.text.isEmpty ||
              _usernameController.text.isEmpty) {
            displayToast("All fields are required");
          }

          // Proceed to signup
          else {
            String res = await FireAuth().signUpWithEmailAndPass(
                profilePic: _image!,
                username: _usernameController.text,
                bio: _bioController.text,
                email: _emailController.text,
                password: _passController.text);
            if (res == "Success") {
              Navigator.popAndPushNamed(context, '/home');
            } else {
              displayToast(res);
            }
          }
          setState(() => isloading = false); // Turn off loading spinner
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
    _bioController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}

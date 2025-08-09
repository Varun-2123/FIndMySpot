import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/screens/login/loginscreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Registrationscreen extends StatefulWidget {
  const Registrationscreen({super.key});

  @override
  State<Registrationscreen> createState() => _RegistrationscreenState();
}

class WavyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.25);

    path.quadraticBezierTo(
      size.width * 0.20,
      size.height * 0.55,
      size.width * 0.40,
      size.height * 0.5,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.4,
      size.width,
      size.height * 0.75,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _RegistrationscreenState extends State<Registrationscreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isHidden = true;
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: WavyClipper(),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF001b4b),
                        Color(0xff002c7c),
                        Color(0xFF738dbe),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 10.w,
                child: SizedBox(
                  height: 120.h,
                  width: 340.w,
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Uihelper.customText(
                        text: "Create Your Account",
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        size: 33,
                        fontFamily: "Medium",
                      ),
                      SizedBox(height: 5.h),
                      Uihelper.customText(
                        text: "Please enter your details to Sign up",
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 50.h),
          Row(
            children: [
              SizedBox(width: 22.w),
              Uihelper.customText(
                text: "Sign up",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.bold,
                fontFamily: "Medium",
                size: 28,
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 320.w,
            child: TextField(
              keyboardType: TextInputType.text,
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Username",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: 320.w,
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 15.h),
          SizedBox(
            width: 320.w,
            child: TextField(
              obscureText: isHidden,
              keyboardType: TextInputType.text,
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isHidden = !isHidden;
                    });
                  },
                  child: Icon(Icons.remove_red_eye),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              SizedBox(width: 10.w),
              Checkbox(
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
                activeColor: Colors.blue,
                checkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Uihelper.customText(
                text: "I Agree to Terms & Conditions",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.w400,
                size: 17,
              ),
              SizedBox(width: 8.w),
            ],
          ),
          SizedBox(height: 25.h),
          InkWell(
            onTap: () {
              if (nameController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  passwordController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "All Fields are required!",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.only(
                      top: 40, // distance from top
                      left: 10,
                      right: 10,
                      bottom: 760,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else if (!isChecked) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      "Please agree to the Terms & Conditions",
                      style: TextStyle(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: Colors.red,
                    behavior: SnackBarBehavior.floating,
                    margin: const EdgeInsets.only(
                      top: 40, // distance from top
                      left: 10,
                      right: 10,
                      bottom: 760,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Homescreen()),
                );
              }
            },
            child: Uihelper.loginButton(
              text: "Sign up",
              color: Appcolors.blueButton,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(width: 70.w),
              Uihelper.customText(
                text: "Already have an account?",
                color: Colors.black,
                fontWeight: FontWeight.normal,
                size: 14,
              ),
              SizedBox(width: 3.w),
              InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Loginscreen(),
                    ),
                  );
                },
                child: Uihelper.customText(
                  text: "Login",
                  color: Appcolors.blueButton,
                  fontWeight: FontWeight.normal,
                  size: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

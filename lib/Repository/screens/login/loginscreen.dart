import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/registration/registrationscreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
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

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  var isNotVisible = true;
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        text: "Welcome Back",
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        size: 33,
                        fontFamily: "Medium",
                      ),
                      SizedBox(height: 5.h),
                      Uihelper.customText(
                        text: "Please enter your details to Login",
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
                text: "Login",
                color: Appcolors.blueButton,
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
              keyboardType: TextInputType.emailAddress,
              controller: emailcontroller,
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
              obscureText: isNotVisible,
              keyboardType: TextInputType.text,
              controller: passwordcontroller,
              decoration: InputDecoration(
                hintText: "Password",
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isNotVisible = !isNotVisible;
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
                text: "Remember me",
                color: Appcolors.mainBlack,
                fontWeight: FontWeight.w400,
                size: 17,
              ),
              SizedBox(width: 48.w),
              InkWell(
                onTap: () {},
                child: Uihelper.customText(
                  text: "Forgot Password?",
                  color: Appcolors.mainBlack,
                  fontWeight: FontWeight.w400,
                  size: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          Uihelper.loginButton(text: "Login", color: Appcolors.blueButton),
          SizedBox(height: 10.h),
          Row(
            children: [
              SizedBox(width: 70.w),
              Uihelper.customText(
                text: "Don't have an account?",
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
                      builder: (context) => Registrationscreen(),
                    ),
                  );
                },
                child: Uihelper.customText(
                  text: "Sign Up",
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

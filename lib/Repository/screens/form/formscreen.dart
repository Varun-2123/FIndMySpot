import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:parking_app/Data/services/firebase/store/store.dart';
import 'package:parking_app/Domain/constants/AppColors.dart';
import 'package:parking_app/Repository/screens/homescreen/homescreen.dart';
import 'package:parking_app/Repository/widgets/uihelper.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

const String cloudName = "dgkxfp5qx";
const String uploadPreset = "fyedfgt3";

class Formscreen extends StatefulWidget {
  const Formscreen({super.key});

  @override
  State<Formscreen> createState() => _FormscreenState();
}

class _FormscreenState extends State<Formscreen> {
  final ImagePicker _picker = ImagePicker();
  String? _uploadedImageUrl;
  // bool _isUploading = false;
  var nameController = TextEditingController();
  var numberController = TextEditingController();
  var emailController = TextEditingController();

  var gender = [
    {"gender": "Male", "Icon": FontAwesomeIcons.mars, "tapped": "f"},
    {"gender": "Female", "Icon": FontAwesomeIcons.venus, "tapped": "f"},
    // ye badal dio transgender
    {
      "gender": "Other",
      "Icon": FontAwesomeIcons.personHalfDress,
      "tapped": "t",
    },
  ];
  var selectedGender = "Other";
  var imgsrc =
      "https://res.cloudinary.com/dgkxfp5qx/image/upload/v1757608320/defaultUser_r9g9r8.png";

  Future<String?> uploadImage(File file) async {
    final uri = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );

    var request =
        http.MultipartRequest("POST", uri)
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = "Prototype Demo"
          ..files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      final resData = await response.stream.bytesToString();
      final data = json.decode(resData);
      return data["secure_url"];
    } else {
      debugPrint("Upload failed: ${response.statusCode}");
      return null;
    }
  }

  Future<void> pickImage(ImageSource source) async {
    if (source == ImageSource.camera) {
      if (await Permission.camera.request().isDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Camera permission denied")),
          );
          return;
        }
      }
    } else {
      if (await Permission.photos.request().isDenied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Gallery permission denied")),
          );
          return;
        }
      }
    }

    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile == null) return;

    // setState(() => _isUploading = true);

    final url = await uploadImage(File(pickedFile.path));

    setState(() {
      // _isUploading = false;
      _uploadedImageUrl = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.mainWhite,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 65.h),
            Uihelper.customText(
              text: "Add Details",
              color: Colors.black,
              fontWeight: FontWeight.w600,
              size: 36,
              fontFamily: "Medium",
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 260.h,
              width: 210.w,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 130.r,
                    backgroundColor: Appcolors.mainWhite,
                    // yaha se image add hoga jo bhi yaha wo data base me
                    backgroundImage:
                        _uploadedImageUrl == null
                            ? NetworkImage(imgsrc)
                            : NetworkImage(_uploadedImageUrl!),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 175, left: 165),
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: Appcolors.mainYellow,
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          // can improve the delay a bit but works if awaited a bit
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext bc) {
                              return SafeArea(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                      leading: Icon(Icons.photo_library),
                                      title: Text('Gallery'),
                                      onTap: () {
                                        pickImage(ImageSource.gallery);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Camera'),
                                      onTap: () {
                                        pickImage(ImageSource.camera);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.pencil,
                          color: Appcolors.mainBlack,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            // name input field
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 8.0,
              ),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            // gender Selector
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 8.0,
              ),
              child: SizedBox(
                height: 75.h,
                child: Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedGender = gender[index]["gender"].toString();
                            for (int i = 0; i < gender.length; i++) {
                              gender[i]["tapped"] = "f";
                            }
                            gender[index]["tapped"] = "t";
                          });
                        },
                        child: Uihelper.genderChoice(
                          tapped: gender[index]["tapped"].toString(),
                          icon: gender[index]["Icon"] as IconData,
                        ),
                      );
                    },
                    itemCount: gender.length,
                  ),
                ),
              ),
            ),
            // Number input field
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 8.0,
              ),
              child: TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: SizedBox(
                    width: 50.w,
                    height: 50.h,
                    // color: Colors.red,
                    child: Center(
                      child: Row(
                        children: [SizedBox(width: 20.w), Text("+91")],
                      ),
                    ),
                  ),
                  labelText: "Mobile Number",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            // email
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 22.0,
                vertical: 8.0,
              ),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 120.h),
            InkWell(
              onTap: () async {
                if (emailController.text.isEmpty ||
                    nameController.text.isEmpty ||
                    numberController.text.isEmpty) {
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
                } else {
                  final flag = await Store.uploadUser(
                    name: nameController,
                    email: emailController,
                    phone: numberController,
                    gender: selectedGender,
                    imageUrl: _uploadedImageUrl ?? imgsrc,
                    context: context,
                  );
                  if (flag && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          "Successfully Uploaded",
                          style: TextStyle(color: Colors.white),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: Appcolors.mainGreen,
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

                    Future.delayed(Duration(seconds: 2), () {
                      if (context.mounted) {
                        // Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Homescreen()),
                        );
                      }
                    });
                  }
                }
              },
              child: Uihelper.yellowButton(text: "Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

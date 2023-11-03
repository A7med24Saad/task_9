import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_9/cash.dart';
import 'package:task_9/core/color.dart';
import 'package:task_9/core/styles.dart';
import 'package:task_9/features/Home_View.dart';

String? imagepath;
String name = '';

class firstscreen extends StatefulWidget {
  const firstscreen({super.key});

  @override
  State<firstscreen> createState() => _firstscreenState();
}

class _firstscreenState extends State<firstscreen> {
  @override
  void initState() {
    super.initState();
    cash.get(cash.Image).then((value) {
      setState(() {
        imagepath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  if (imagepath != null && name.isNotEmpty) {
                    //
                    cash.cashd(cash.NameKey, name);
                    cash.cashd(cash.Image, imagepath!);
                    cash.cashbool(cash.isupload, true);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ));
                  } else if (imagepath == null && name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content:
                            Text('Please Upload Image and Enter Your Name')));
                  } else if (imagepath == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please Upload Image')));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Please Enter Your Name')));
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: AppColors.primaryColor),
                ))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: AppColors.primaryColor,
                backgroundImage: (imagepath != null)
                    ? FileImage(File(imagepath!)) as ImageProvider
                    : const AssetImage('assets/person-icon.svg'),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        cameraImage();
                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColor,
                        ),
                        child: Center(
                          child: Text('Upload from camera',
                              style: getSmallTextStyle()),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        galleryImage();
                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.primaryColor,
                        ),
                        child: Center(
                          child: Text('Upload from Gallery',
                              style: getSmallTextStyle()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Divider(
                color: AppColors.primaryColor,
                height: 0.7,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIconColor: AppColors.primaryColor,
                  labelText: 'Enter Your Name',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(Icons.person),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  cameraImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      cash.cashd(cash.Image, pickedImage.path);
      setState(() {
        imagepath = pickedImage.path;
      });
    }
  }

  galleryImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      cash.cashd(cash.Image, pickedImage.path);
      setState(() {
        imagepath = pickedImage.path;
      });
    }
  }
}

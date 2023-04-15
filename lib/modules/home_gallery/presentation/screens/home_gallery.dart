import 'dart:io';
import 'dart:ui';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gallery/modules/home_gallery/presentation/store/home_gallery_states.dart';
import 'package:my_gallery/modules/login/presentation/screens/login_screen.dart';
import 'package:my_gallery/shared/local/shared_prefrence.dart';

import '../components/button_home_gallery.dart';
import '../store/home_gallery_cubit.dart';

class HomeGallery extends StatelessWidget {
  bool isVideo = false;

  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return BlocProvider(
      create: (context) {
        return HomeGalleryCubit()
          ..getImages(token: MyGallerySharedPreferences.get("myToken"));
      },
      child: BlocConsumer<HomeGalleryCubit, HomeGalleryStates>(
        listener: (context, state) {
          if (state is UploadSuccess) {
            HomeGalleryCubit.get(context).showUploadDialog(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(HomeGalleryCubit.get(context).message!),
              ),
            );
            HomeGalleryCubit.get(context)
                .getImages(token: MyGallerySharedPreferences.get("myToken"));
          } else if (state is UploadFaild) {
            HomeGalleryCubit.get(context).showUploadDialog(false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(HomeGalleryCubit.get(context).message!),
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = HomeGalleryCubit.get(context);

          return Scaffold(
            body: Padding(
              padding: EdgeInsets.only(top: mq.size.height * 0.047),
              child: Container(
                width: mq.size.width,
                height: mq.size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/gallery_home.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: mq.size.width * 0.07,
                            vertical: mq.size.height * 0.018,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Text(
                                  "Welcome ${MyGallerySharedPreferences.get("myName")}",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff4A4A4A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child:
                                      Image.asset("assets/images/profile.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: mq.size.height * 0.01,
                        ),
                        Container(
                          width: mq.size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomButtonGallery(
                                name: "Log out",
                                imageName: "assets/images/log_out.png",
                                arrowName: "assets/images/arrow_left.png",
                                onTapAction: () {
                                  MyGallerySharedPreferences.setBool(
                                      "isLoginSuccess", false);
                                  MyGallerySharedPreferences.setString(
                                      "myToken", null);
                                  MyGallerySharedPreferences.setString(
                                      "myName", null);
                                  MyGallerySharedPreferences.setInt(
                                      "myId", null);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                      (route) => false);
                                },
                              ),
                              CustomButtonGallery(
                                name: "Upload",
                                imageName: "assets/images/upload.png",
                                arrowName: "assets/images/arrow_up.png",
                                onTapAction: () {
                                  cubit.showUploadDialog(true);
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          width: mq.size.width,
                          height: mq.size.height * 0.75,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: GridView.count(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 8.0,
                            children: List.generate(
                                cubit.images == null ? 0 : cubit.images!.length,
                                (index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(fit: BoxFit.fill,cubit.images == null
                                    ? ""
                                    : cubit.images![index]),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),
                    if (cubit!.isShowen)
                      GestureDetector(
                        onTap: () {
                          cubit.showUploadDialog(false);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: ClipRect(
                            child: BackdropFilter(
                              filter: new ImageFilter.blur(
                                  sigmaX: 10.0, sigmaY: 10.0),
                              child: Container(
                                decoration: new BoxDecoration(
                                  color: Colors.grey.shade200.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: mq.size.height * 0.32,
                                width: mq.size.width * 0.65,
                                child: Column(

                                  children: [
                                    SizedBox(
                                      height: mq.size.height * 0.03,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: CustomButtonGallery(
                                        buttonColor: Color(0xffEFD8F9),
                                        name: "Gallery",
                                        imageName: "assets/images/gallery.png",
                                        // arrowName: "assets/images/arrow_left.png",
                                        onTapAction: () async {
                                          cubit.pickImage(
                                              MyGallerySharedPreferences.get(
                                                  "myToken"));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: mq.size.height * 0.03,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: CustomButtonGallery(
                                        buttonColor: Color(0xffEBF6FF),
                                        name: "Camera",
                                        imageName: "assets/images/camera.png",
                                        // arrowName: "assets/images/arrow_left.png",
                                        onTapAction: () async {
                                          cubit.takePhoto(
                                              MyGallerySharedPreferences.get(
                                                  "myToken"));
                                          cubit.showUploadDialog(false);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

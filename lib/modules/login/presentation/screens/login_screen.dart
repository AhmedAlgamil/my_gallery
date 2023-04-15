import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/modules/home_gallery/presentation/screens/home_gallery.dart';
import 'package:my_gallery/modules/login/presentation/store/login_cubit.dart';
import 'package:my_gallery/modules/login/presentation/store/login_states.dart';
import 'package:my_gallery/shared/local/shared_prefrence.dart';

import '../components/text_input.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController? userNameController = new TextEditingController();
  TextEditingController? passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginLoadedState) {
            if (LoginCubit.get(context).userDataModel!.token == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("noooo"),
              ));
            } else {
              MyGallerySharedPreferences.setBool("isLoginSuccess", true);
              MyGallerySharedPreferences.setString(
                  "myToken", LoginCubit.get(context).userDataModel!.token);
              MyGallerySharedPreferences.setString(
                  "myName", LoginCubit.get(context).userDataModel!.data!.name);
               MyGallerySharedPreferences.setInt(
                  "myId", LoginCubit.get(context).userDataModel!.data!.id);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeGallery(),
                  ),
                  (route) => false);
            }
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);

          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: mq.size.width,
                height: mq.size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login_page.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: mq.size.height * 0.25,
                    ),
                    const Text(
                      "My Gallery",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff4A4A4A),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: mq.size.height * 0.04,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: mq.size.height * 0.16),
                      child: ClipRect(
                        child: BackdropFilter(
                          filter:
                              new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Container(
                            height: mq.size.height * 0.5,
                            width: mq.size.width * 0.78,
                            decoration: new BoxDecoration(
                                color: Colors.grey.shade200.withOpacity(0.5)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: mq.size.height * 0.04,
                                  ),
                                  const Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: Color(0xff4A4A4A),
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.03,
                                  ),
                                  CustomTextField(
                                    textController: userNameController,
                                    hint: "User Name",
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.03,
                                  ),
                                  CustomTextField(
                                    textController: passwordController,
                                    hint: "Password",
                                    isSecured: true,
                                  ),
                                  SizedBox(
                                    height: mq.size.height * 0.03,
                                  ),
                                  Container(
                                    width: mq.size.width * 0.7,
                                    height: mq.size.height * 0.06,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0xff7BB3FF),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        cubit.login(
                                            email: userNameController!.text,
                                            password: passwordController!.text);
                                      },
                                      child: const Text(
                                        "SUBMIT",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
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

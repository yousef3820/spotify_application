import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/widgets/button/basic_app_button.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_images.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_vector.dart';
import 'package:flutter_spotify_application_1/presentation/features/auth/pages/signup_or_signin_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter_svg/svg.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chooseModeImage),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.15)),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                Spacer(),
                Text(
                  "Choose mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(
                              ThemeMode.dark,
                            );
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(
                                    0xff30393c,
                                  ).withValues(alpha: 0.5),
                                ),
                                width: 80,
                                height: 80,
                                child: SvgPicture.asset(
                                  AppVectors.darkTheme,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Text(
                          "Dark Mode",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 71),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.read<ThemeCubit>().updateTheme(
                              ThemeMode.light,
                            );
                          },
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(
                                    0xff30393c,
                                  ).withValues(alpha: 0.5),
                                ),
                                width: 80,
                                height: 80,
                                child: SvgPicture.asset(
                                  AppVectors.lightTheme,
                                  fit: BoxFit.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 17),
                        Text(
                          "Light Mode",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 70),
                BasicAppButton(
                  title: "Continue",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupOrSigninPage();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

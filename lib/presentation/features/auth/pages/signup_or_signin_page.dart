import 'package:flutter/material.dart';
import 'package:flutter_spotify_application_1/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_images.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_vector.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/presentation/features/auth/pages/signin_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/auth/pages/signup_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BasicAppBar(),
          Align(
            alignment: Alignment.bottomRight,
            child: SvgPicture.asset(AppVectors.pattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.signinImage),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppVectors.logo),
                SizedBox(height: 25),
                Text(
                  "Enjoy listening to music",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                SizedBox(height: 21),
                Text(
                  textAlign: TextAlign.center,
                  "Spotify is a proprietary Swedish audio streaming and media services provider",
                  style: TextStyle(color: Color(0xff797979), fontSize: 17),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignupPage();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 19,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: 89),
                    ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SigninPage();
                            },
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: AppColors.primary, width: 2),
                        ),
                        backgroundColor: Colors.transparent, // ✅ no background
                        shadowColor: Colors.transparent, // ✅ removes shadow
                        elevation: 0,
                      ),
                      child: Text(
                        "sign in",
                        style: TextStyle(
                          fontSize: 19,
                          color: context.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

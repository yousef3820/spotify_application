import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spotify_application_1/common/widgets/button/basic_app_button.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_images.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_vector.dart';
import 'package:flutter_spotify_application_1/presentation/features/choose_mode/pages/choose_mode.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.getStartedImg),
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
                  "Enjoy listening to music",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 21),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sagittis enim purus sed phasellus. Cursus ornare id scelerisque aliquam.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, color: Color(0xff797979)),
                ),
                SizedBox(height: 37),
                BasicAppButton(
                  title: "Get started",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChooseModePage();
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

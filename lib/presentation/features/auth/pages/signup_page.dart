import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify_application_1/common/widgets/button/basic_app_button.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_vector.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/data/model/auth/create_user_request.dart';
import 'package:flutter_spotify_application_1/domain/usecases/signup_usecae.dart';
import 'package:flutter_spotify_application_1/presentation/features/auth/bloc/cubit/password_visibility_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/auth/pages/signin_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/home/pages/home.dart';
import 'package:flutter_spotify_application_1/serviceLocator.dart';
import 'package:flutter_svg/svg.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordVisibilityCubit(),
      child: Scaffold(
        appBar: BasicAppBar(
          title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RegisteText(),
                SizedBox(height: 15),
                TextField(
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(hintText: "Full name"),
                  controller: _fullName,
                ),
                SizedBox(height: 16),
                TextField(
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(hintText: "Enter email"),
                  controller: _email,
                ),
                SizedBox(height: 16),
                BlocBuilder<PasswordVisibilityCubit, bool>(
                  builder: (context, state) {
                    return TextField(
                      obscureText: state,
                      cursorColor: AppColors.primary,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            context
                                .read<PasswordVisibilityCubit>()
                                .toggleVisibility();
                          },
                          icon: Icon(
                            state ? Icons.visibility_off : Icons.visibility,
                          ),
                        ),
                      ),
                      controller: _password,
                    );
                  },
                ),
                SizedBox(height: 33),
                BasicAppButton(
                  onPressed: () async {
                    final name = _fullName.text.trim();
                    final email = _email.text.trim();
                    final password = _password.text.trim();
                    // Basic validation
                    if (name.isEmpty || email.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "All fields are required.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.orange,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }
                    // Email format validation
                    final emailRegex = RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    );
                    if (!emailRegex.hasMatch(email)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.email_outlined, color: Colors.white),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "Please enter a valid email address.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.deepPurple,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          duration: Duration(seconds: 3),
                        ),
                      );
                      return;
                    }
                    var result = await sl<SignupUsecae>().execute(
                      params: CreateUserRequest(
                        fullName: _fullName.text.toString(),
                        email: _email.text.toString(),
                        password: _password.text.toString(),
                      ),
                    );
                    result.fold(
                      (l) {
                        final snackbar = SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.error_outline, color: Colors.white),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  l.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 8,
                          duration: Duration(seconds: 3),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                      (r) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ),
                        );
                      },
                    );
                  },
                  title: "creat account",
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Do you have an account?",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SigninPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "sign in",
                        style: TextStyle(
                          color: Color(0xff35a030),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisteText extends StatelessWidget {
  const RegisteText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Register",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
    );
  }
}

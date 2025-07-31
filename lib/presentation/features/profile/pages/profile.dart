import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/helpers/capitalize_name.dart';
import 'package:flutter_spotify_application_1/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/presentation/features/auth/pages/signin_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/profile/bloc/cubit/profile_info_cubit_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/widgets/mini_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
          return MiniPlayer();
        },
      ),
      appBar: BasicAppBar(
        backgroundColor: Color(0xff2C2B2B),
        title: Text("Profile"),
      ),
      body: Column(children: [_profile(context)]),
    );
  }

  Widget _profile(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileInfoCubitCubit()..getUser(),
      child: BlocBuilder<ProfileInfoCubitCubit, ProfileInfoCubitState>(
        builder: (context, state) {
          if (state is ProfileInfoCubitLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          } else if (state is ProfileInfoCubitFailure) {
            return Center(child: Text(state.message));
          } else if (state is ProfileInfoCubitLoaded) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? Color(0xff2C2B2B)
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.account_circle, size: 70, color: Colors.grey),
                      SizedBox(height: 10),
                      Text(
                        state.user.fullName!.capitalizeEachWord(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        state.user.email!,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                /// Logout Button
                _buildProfileAction(
                  context,
                  icon: Icons.logout,
                  label: "Logout",
                  onTap: () async {
                    context
                        .read<SongPlayerCubit>()
                        .stopMusic(); // Stop the song
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SigninPage()),
                      (route) => false,
                    );
                  },
                ),

                /// Theme Switch Button
                _buildProfileAction(
                  context,
                  icon: Icons.brightness_6,
                  label: "Toggle Theme",
                  onTap: () {
                    final themeCubit = context.read<ThemeCubit>();
                    themeCubit.updateTheme(
                      context.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                    );
                  },
                ),
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

Widget _buildProfileAction(
  BuildContext context, {
  required IconData icon,
  required String label,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        decoration: BoxDecoration(
          color: context.isDarkMode ? Colors.grey.shade800 : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Icon(icon, size: 28),
          ],
        ),
      ),
    ),
  );
}

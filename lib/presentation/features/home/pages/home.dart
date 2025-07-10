import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify_application_1/common/helpers/is_dark_mode.dart';
import 'package:flutter_spotify_application_1/common/widgets/appbar/app_bar.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_images.dart';
import 'package:flutter_spotify_application_1/core/configs/assets/app_vector.dart';
import 'package:flutter_spotify_application_1/core/configs/theme/app_colors.dart';
import 'package:flutter_spotify_application_1/presentation/features/favourites/pages/favourites_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/home/widgets/newest_songs.dart';
import 'package:flutter_spotify_application_1/presentation/features/home/widgets/play_list_songs.dart';
import 'package:flutter_spotify_application_1/presentation/features/profile/pages/profile.dart';
import 'package:flutter_spotify_application_1/presentation/features/search/pages/search_page.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/bloc/cubit/song_player_cubit.dart';
import 'package:flutter_spotify_application_1/presentation/features/song_player/widgets/mini_player.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
          return MiniPlayer();
        },
      ),
      appBar: BasicAppBar(
        hideBack: true,
        centerTitle: false,
        title: SvgPicture.asset(AppVectors.logo, height: 40, width: 40),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ProfilePage();
                  },
                ),
              );
            },
            icon: Icon(Icons.person , size: 30, color: AppColors.primary,),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return FavoritesWidget();
                  },
                ),
              );
            },
            icon: Icon(Icons.favorite, size: 30, color: AppColors.primary,),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SearchPage();
                  },
                ),
              );
            },
            icon: Icon(Icons.search,size: 30, color: AppColors.primary,),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Header section
          SliverToBoxAdapter(
            child: SizedBox(
              height: 188,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(
                      AppVectors.hoemPageContainer,
                      height: 135,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(AppImages.homePageImage),
                  ),
                ],
              ),
            ),
          ),

          // Tab bar
          SliverToBoxAdapter(child: _tabs()),

          // Spacing
          SliverToBoxAdapter(child: SizedBox(height: 20)),

          // Tab content (Newest Songs)
          SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: TabBarView(
                controller: _tabController,
                children: [
                  NewestSongs(),
                  NewestSongs(),
                  NewestSongs(),
                ],
              ),
            ),
          ),

          // Playlist section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Songs",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          PlayListSongs(),
        ],
      ),
    );
  }

  Widget _tabs() {
    return TabBar(
      tabAlignment: TabAlignment.center,
      controller: _tabController,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 3,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      labelPadding: EdgeInsets.symmetric(horizontal: 16),
      labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      tabs: const [
        Tab(text: "Newest"),
        Tab(text: "Popular"),
        Tab(text: "Most Played"),
      ],
    );
  }
}

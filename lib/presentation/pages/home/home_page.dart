import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../../../bloc/theme/theme_bloc.dart';
import '../../../data/repositories/song_repository.dart';
import '../../components/home_drawer.dart';
import '../../components/player_bottom_app_bar.dart';
import '../../utils/app_router.dart';
import '../../utils/theme/themes.dart';
import 'views/albums_view.dart';
import 'views/artists_view.dart';
import 'views/genres_view.dart';
import 'views/songs_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  late final SongRepository songRepository;
  late TabController _tabController;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    checkAndRequestPermissions();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Future checkAndRequestPermissions({bool retry = false}) async {
    // The param 'retryRequest' is false, by default.
    _hasPermission = await _audioQuery.checkAndRequest(
      retryRequest: retry,
    );

    // Only call update the UI if application has all required permissions.
    _hasPermission ? setState(() {}) : checkAndRequestPermissions(retry: true);
  }

  final tabs = [
    'Songs',
    'Artists',
    'Albums',
    'Genres',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Themes.getTheme().primaryColor,
            title: const Text('DartMusic'),
          ),
          drawer: const HomeDrawer(),
          // current song, play/pause button, song progress bar, song queue button
          bottomNavigationBar: const PlayerBottomAppBar(),
          body: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  gradient: Themes.getTheme().linearGradient,
                ),
                child: _hasPermission
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.lightBlueAccent,
                                  child: SizedBox(
                                    width: 95,
                                    height: 95,
                                    child: Center(
                                      child: SizedBox(
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                            child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                AppRouter.favoritesRoute);
                                          },
                                          icon:
                                              Icon(Icons.favorite_border_sharp),
                                          iconSize: 40,
                                          color: Themes.getTheme().primaryColor,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.5),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.lightBlueAccent,
                                  child: SizedBox(
                                    width: 95,
                                    height: 95,
                                    child: Center(
                                      child: SizedBox(
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                            child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                AppRouter.playlistsRoute);
                                          },
                                          icon: Icon(
                                              Icons.playlist_add_check_sharp),
                                          iconSize: 40,
                                          color: Themes.getTheme().primaryColor,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5.5),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.lightBlueAccent,
                                  child: SizedBox(
                                    width: 95,
                                    height: 95,
                                    child: Center(
                                      child: SizedBox(
                                        width: 300,
                                        height: 100,
                                        child: Center(
                                            child: IconButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                AppRouter.recentsRoute);
                                          },
                                          icon: Icon(Icons.recent_actors_sharp),
                                          color: Themes.getTheme().primaryColor,
                                          iconSize: 40,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          TabBar(
                            controller: _tabController,
                            tabs: tabs.map((e) => Tab(text: e)).toList(),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _tabController,
                              children: const [
                                SongsView(),
                                ArtistsView(),
                                AlbumsView(),
                                GenresView(),
                              ],
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text('No permission to access library'),
                      ),
              )),
        );
      },
    );
  }
}

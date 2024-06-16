import 'package:audio_service/audio_service.dart';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../pages/about_page.dart';
import '../pages/album_page.dart';
import '../pages/artist_page.dart';
import '../pages/favorites_page.dart';
import '../pages/genre_page.dart';
import '../pages/home/home_page.dart';
import '../pages/player_page.dart';
import '../pages/playlists_page.dart';
import '../pages/recents_page.dart';
import '../pages/settings_page.dart';
import '../pages/splash_page.dart';

class AppRouter {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String favoritesRoute = '/favorites';
  static const String playlistsRoute = '/playlists';
  static const String recentsRoute = '/recents';
  static const String playerRoute = '/player';
  static const String artistRoute = '/artist';
  static const String albumRoute = '/album';
  static const String genreRoute = '/genre';
  static const String aboutRoute = '/about';
  static const String settingsRoute = '/settings';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashPage(),
        );
      case homeRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const HomePage(),
        );
      case favoritesRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const FavoritesPage(),
        );
      case playlistsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const PlaylistsPage(),
        );
      case recentsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const RecentsPage(),
        );
      case playerRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => PlayerPage(
            mediaItem: settings.arguments as MediaItem,
          ),
        );
      case artistRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => ArtistPage(
            artist: settings.arguments as ArtistModel,
          ),
        );
      case albumRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => AlbumPage(
            album: settings.arguments as AlbumModel,
          ),
        );
      case genreRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => GenrePage(
            genre: settings.arguments as GenreModel,
          ),
        );
      case aboutRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const AboutPage(),
        );
      case settingsRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SettingsPage(),
        );
      default:
        return MaterialPageRoute<dynamic>(
          builder: (_) => const SplashPage(),
        );
    }
  }
}

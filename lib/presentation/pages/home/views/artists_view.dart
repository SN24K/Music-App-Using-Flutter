import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:on_audio_query/on_audio_query.dart';

import '../../../../bloc/home/home_bloc.dart';
import '../../../utils/app_router.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({super.key});

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final audioQuery = OnAudioQuery();
  final artists = <ArtistModel>[];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(GetArtistsEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is ArtistsLoaded) {
          setState(() {
            artists.clear();
            artists.addAll(state.artists);
            isLoading = false;
          });
        }
      },
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : AnimationLimiter(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  final artist = artists[index];

                  return AnimationConfiguration.staggeredGrid(
                    position: index,
                    duration: const Duration(milliseconds: 500),
                    columnCount: 2,
                    child: FlipAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            AppRouter.artistRoute,
                            arguments: artist,
                          );
                        },
                        child: Column(
                          children: [
                            QueryArtworkWidget(
                              id: artist.id,
                              type: ArtworkType.ARTIST,
                              artworkHeight: 96,
                              artworkWidth: 96,
                              artworkBorder: BorderRadius.circular(100),
                              nullArtworkWidget: Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                                child: const Icon(
                                  Icons.person,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              artist.artist,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

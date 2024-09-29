import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:http_bloc_task2/business_logic/random_images_bloc/random_images_bloc.dart';
import 'package:http_bloc_task2/business_logic/slider_bloc/slider_bloc.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/view/widgets/main_drawer.dart';
import 'package:http_bloc_task2/view/widgets/image_slider.dart';
import 'package:http_bloc_task2/view/widgets/image_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();


    BlocProvider.of<RandomImageBloc>(context).add(FetchRandomImagesEvent());
    BlocProvider.of<SliderBloc>(context).add(FetchSliderTopicsEvent());

    scrollController.addListener(onScroll);
  }

  void onScroll() {
    final offset = scrollController.offset;
    final maxScroll = scrollController.position.maxScrollExtent;

    if (offset >= maxScroll * 0.9) {
      context.read<RandomImageBloc>().add(FetchMoreRandomImagesEvent());
    }
  }

  Widget toggleFavorite(ImageObject image) {
    return GestureDetector(
      child: const Icon(Icons.star),
      onTap: () async {
        context.read<FavoritesCubit>().addFavorite(image);
      },
    );
  }

  Future<void> selectScreen(String screen) async {
    Navigator.of(context).pop();
    if (screen == "favorite") {
      Navigator.of(context).pushNamed('/favorite');
    }
    if (screen == "search") {
      Navigator.of(context).pushNamed('/search');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        onSelectScreens: selectScreen,
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey[400],
        title: const Text("Infinite Images"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: ImageSlider(),
                ),
              ),
            ),
            BlocBuilder<RandomImageBloc, RandomImageState>(
              builder: (context, state) {
                if (state.randomImages.isNotEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index < state.randomImages.length) {
                          final image = state.randomImages[index];
                          final aspectRatio = image.width! / image.height!;
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height:
                                MediaQuery.of(context).size.width / aspectRatio,
                            child: ImageWidget(image: image),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                      childCount: state.randomImages.length +
                          (state.status == Status.loadingMore ? 1 : 0),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

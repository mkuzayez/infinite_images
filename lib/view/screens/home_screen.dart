import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:http_bloc_task2/business_logic/random_images_cubit/cubit/random_images_cubit.dart';
import 'package:http_bloc_task2/business_logic/random_images_cubit/cubit/random_images_state.dart';
import 'package:http_bloc_task2/business_logic/slider_bloc/slider_bloc.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/data/web_services/network_exceptions.dart';
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

    BlocProvider.of<RandomImagesCubit>(context).getRandomImages();
    BlocProvider.of<SliderBloc>(context).add(FetchSliderTopicsEvent());

    scrollController.addListener(onScroll);
  }

  void onScroll() {
    final offset = scrollController.offset;
    final maxScroll = scrollController.position.maxScrollExtent;

    if (offset >= maxScroll * 0.9) {
      context.read<RandomImagesCubit>().loadMoreRandomImages();
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

  void showErrorDialog(NetworkExceptions exception) {
    final errorMessage = NetworkExceptions.getErrorMessage(exception);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Error"),
        content: Text(errorMessage),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
        ],
      ),
    );
  }

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
            BlocBuilder<RandomImagesCubit, ResultState<List<ImageObject>>>(
              builder: (context, state) {
                print("current $state");
                return state.when(
                  idle: () => const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  loading: () => const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  loadingMore: () => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final image = state.data[index];
                        final aspectRatio = image.width! / image.height!;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height:
                              MediaQuery.of(context).size.width / aspectRatio,
                          child: ImageWidget(image: image),
                        );
                      },
                      childCount:
                          (state as Success<List<ImageObject>>).data.length + 1,
                    ),
                  ),
                  success: (images) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final image = state.data[index];
                        final aspectRatio = image.width! / image.height!;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height:
                              MediaQuery.of(context).size.width / aspectRatio,
                          child: ImageWidget(image: image),
                        );
                      },
                      childCount:
                          (state as Success<List<ImageObject>>).data.length + 1,
                    ),
                  ),
                  error: (NetworkExceptions error) {
                    showErrorDialog(error);
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Failed to load images'),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

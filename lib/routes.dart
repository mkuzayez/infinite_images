import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/download_cubit/download_cubit.dart';
import 'package:http_bloc_task2/business_logic/favorites_cubit/favorites_cubit.dart';
import 'package:http_bloc_task2/business_logic/random_images_bloc/random_images_bloc.dart';
import 'package:http_bloc_task2/business_logic/random_images_cubit/cubit/random_images_cubit.dart';
import 'package:http_bloc_task2/business_logic/search_bloc/search_bloc.dart';
import 'package:http_bloc_task2/business_logic/slider_bloc/slider_bloc.dart';
import 'package:http_bloc_task2/business_logic/topic_images_bloc/topic_images_bloc.dart';
import 'package:http_bloc_task2/data/hive_storage.dart';
import 'package:http_bloc_task2/data/images_repository.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';
import 'package:http_bloc_task2/data/web_services/data_provider.dart';
import 'package:http_bloc_task2/view/screens/details_screen.dart';
import 'package:http_bloc_task2/view/screens/favorite_screen.dart';
import 'package:http_bloc_task2/view/screens/home_screen.dart';
import 'package:http_bloc_task2/view/screens/search_screen.dart';
import 'package:http_bloc_task2/view/screens/topic_screen.dart';

class AppRouter {
  late ImagesRepository imagesRepository;
  late FavoritesCubit favoritesCubit;
  late DownloadCubit downloadCubit;
  late RandomImageBloc randomImageBloc;
  late SliderBloc generateSliderBloc;
  late TopicImagesBloc topicImagesBloc;
  late SearchPhotosBloc searchPhotosBloc;
  late DataProvider dataProvider;
  late HiveStorage hiveStorage;
  late RandomImagesCubit randomImagesCubit;

  AppRouter() {
    final dio = DioSetup().createDio();
    hiveStorage = HiveStorage();
    dataProvider = DataProvider(dio);
    imagesRepository = ImagesRepository(dataProvider);
    randomImageBloc = RandomImageBloc(imagesRepository);
    generateSliderBloc = SliderBloc(imagesRepository);
    topicImagesBloc = TopicImagesBloc(imagesRepository);
    searchPhotosBloc = SearchPhotosBloc(imagesRepository);
    favoritesCubit = FavoritesCubit(hiveStorage);
    downloadCubit = DownloadCubit();
    randomImagesCubit = RandomImagesCubit(imagesRepository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: randomImagesCubit,
              ),
              BlocProvider.value(
                value: generateSliderBloc,
              ),
              BlocProvider.value(
                value: favoritesCubit,
              ),
            ],
            child: const HomeScreen(),
          ),
        );

      case '/details':
        final imageObject = settings.arguments as ImageObject;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: topicImagesBloc,
              ),
              BlocProvider.value(
                value: downloadCubit,
              ),
            ],
            child: DetailsScreen(image: imageObject),
          ),
        );

      case '/favorite':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: favoritesCubit,
            child: const FavoritesScreen(),
          ),
        );

      case '/topic':
        final topicObject = settings.arguments as TopicObject;
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: topicImagesBloc,
              ),
              BlocProvider.value(
                value: favoritesCubit,
              ),
            ],
            child: TopicScreen(topic: topicObject),
          ),
        );

      case '/search':
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: searchPhotosBloc,
              ),
              BlocProvider.value(
                value: favoritesCubit,
              ),
            ],
            child: const SearchScreen(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: Text('No Route Found'),
            ),
          ),
        );
    }
  }
}

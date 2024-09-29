import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/routes.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ImageObjectAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(LinksAdapter());
  Hive.registerAdapter(UrlsAdapter());

  await Hive.openBox<List>('favoriteItems');

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
      final AppRouter appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'API Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(
            255,
            48,
            63,
            159,
          ),
        ),
        fontFamily: 'SF',
      ),
      onGenerateRoute: appRouter.generateRoute,
      initialRoute: '/',
    );
  }
}

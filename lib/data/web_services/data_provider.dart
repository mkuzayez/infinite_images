import 'package:dio/dio.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';
import 'package:retrofit/http.dart';

part 'data_provider.g.dart';

@RestApi(baseUrl: "https://api.unsplash.com/")
abstract class DataProvider {
  factory DataProvider(Dio dio, {String baseUrl}) = _DataProvider;

  @GET('photos/random?count=10')
  Future<List<ImageObject>> getRandomImages();

  @GET('topics')
  Future<List<TopicObject>> getTopics();

  @GET('topics/{topic}/photos')
  Future<List<ImageObject>> getTopicImages(@Path() String topic, @Query('page') int page);

  @GET('search/photos')
  Future<List<ImageObject>> searchImages(
      @Query('query') String query, @Query('page') int page);
}

class DioSetup {
  Dio createDio() {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['client_id'] =
              'HPRI7Pz2AaDU4owYy4Ia5iIqHyZjiWxUqzD6gW3gUqQ';
          return handler.next(options);
        },
      ),
    );

    dio.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: true,
        requestBody: true,
      ),
    );

    return dio;
  }
}

import 'package:http_bloc_task2/data/models/image/image_model.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';
import 'package:http_bloc_task2/data/web_services/data_provider.dart';

class ImagesRepository {
  final DataProvider dataProvider;

  ImagesRepository(this.dataProvider);

  Future<List<ImageObject>> getRandomImages() async {
    var response = await dataProvider.getRandomImages();
    return response;
  }

  Future<List<TopicObject>> getTopics() async {
    var response = await dataProvider.getTopics();
    return response;
  }

  Future<List<ImageObject>> getTopicImages(String topic, int page) async {
    var response = await dataProvider.getTopicImages(topic, page);
    return response;
  }

  Future<List<ImageObject>> searchImages(String query, int page) async {
    var response = await dataProvider.searchImages(query, page);
    return response; 
  }
}

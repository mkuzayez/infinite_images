import 'package:hive/hive.dart';
import 'package:http_bloc_task2/data/models/image/image_model.dart';

class HiveStorage {
  late Box<List> favoriteBox;

  HiveStorage() {
    favoriteBox = Hive.box<List>('favoriteItems');
  }
  
  Future<List<ImageObject>> loadFavorites() async {
    List<ImageObject> items =
        (favoriteBox.get('favorites', defaultValue: <ImageObject>[]) as List)
            .cast<ImageObject>()
            .toList();

    return items;
  }

  Future<void> addFavorite(ImageObject image) async {
    List<ImageObject> items =
        (favoriteBox.get('favorites', defaultValue: <ImageObject>[]) as List)
            .cast<ImageObject>()
            .toList();

    if (items.contains(image)) return;

    items.add(image);
    await favoriteBox.put('favorites', items);
  }

  Future<void> deleteFavorite(ImageObject image) async {
    List<ImageObject> items =
        (favoriteBox.get('favorites', defaultValue: <ImageObject>[]) as List)
            .cast<ImageObject>()
            .toList();

    if (!items.contains(image)) return;

    items.remove(image);
    await favoriteBox.put('favorites', items);
  }
}

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

part 'wallpaper_state.dart';

class WallpaperCubit extends Cubit<WallpaperState> {
  WallpaperCubit() : super(const WallpaperState());

  Future<void> setWallpaper(String imageUrl, WallpaperType type) async {
    emit(const WallpaperState(status: WallpaperStatus.setting));

    try {
      final imageData = await downloadImage(imageUrl);

      final imagePath = await saveImageToTempDirectory(imageData);

      bool result;
      switch (type) {
        case WallpaperType.home:
          result = await AsyncWallpaper.setWallpaperFromFile(
            filePath: imagePath,
            wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
          );
          break;
        case WallpaperType.lock:
          result = await AsyncWallpaper.setWallpaperFromFile(
            filePath: imagePath,
            wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
          );
          break;
        case WallpaperType.both:
          result = await AsyncWallpaper.setWallpaperFromFile(
            filePath: imagePath,
            wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
          );
          break;
        default:
          result = false;
      }

      if (result) {
        emit(
          const WallpaperState(
            status: WallpaperStatus.success,
          ),
        );
      } else {
        emit(
          const WallpaperState(
            status: WallpaperStatus.error,
          ),
        );
      }
    } catch (e) {
      emit(
        const WallpaperState(
          status: WallpaperStatus.error,
        ),
      );
    }
  }

  Future<Uint8List> downloadImage(String imageUrl) async {
    final response = await Dio().get(
      imageUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    return Uint8List.fromList(response.data);
  }

  Future<String> saveImageToTempDirectory(Uint8List imageData) async {
    final tempDir = await getTemporaryDirectory();
    final imagePath = '${tempDir.path}/wallpaper_image.jpg';
    final file = File(imagePath);

    await file.writeAsBytes(imageData);
    return imagePath;
  }

  void resetState() {
    emit(
      const WallpaperState(
        status: WallpaperStatus.initial,
      ),
    );
  }
}

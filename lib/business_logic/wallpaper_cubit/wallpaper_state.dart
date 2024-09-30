part of 'wallpaper_cubit.dart';

enum WallpaperStatus { initial, setting, success, error }

enum WallpaperType { home, lock, both }

class WallpaperState extends Equatable {
  final WallpaperStatus status;

  const WallpaperState({this.status = WallpaperStatus.initial});

  @override
  List<Object?> get props => [status];
}

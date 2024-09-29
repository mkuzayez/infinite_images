import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'dart:typed_data';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(const DownloadState());

  Future<void> downloadImage(String url) async {
    emit(const DownloadState(status: DownloadStatus.downloading));

    try {
      var response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(response.data),
      );

      if (result['isSuccess']) {
        emit(
          const DownloadState(
            status: DownloadStatus.finishedDownloading,
          ),
        );
      } else {
        emit(
          const DownloadState(
            status: DownloadStatus.error,
          ),
        );
      }
    } catch (e) {
      if (!isClosed) {
        emit(
          const DownloadState(
            status: DownloadStatus.error,
          ),
        );
      }
    }
  }

  void resetState() {
    emit(
      const DownloadState(
        status: DownloadStatus.initial,
      ),
    );
  }
}

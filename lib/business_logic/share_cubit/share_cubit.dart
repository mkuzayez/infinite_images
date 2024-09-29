import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';

part 'share_state.dart';

class ShareImageCubit extends Cubit<ShareImageState> {
  ShareImageCubit() : super(const ShareImageState());

  Future<void> shareImage(String imageUrl) async {
    emit(
      const ShareImageState(
        status: ShareStatus.sharing,
      ),
    );

    try {
      final imageData = await downloadImage(imageUrl);

      final imagePath = await saveImageToTempDirectory(imageData);

      final xFile = XFile(imagePath);
      await Share.shareXFiles([xFile]);

      emit(
        const ShareImageState(
          status: ShareStatus.finishedSharing,
        ),
      );
    } catch (e) {
      emit(
        const ShareImageState(
          status: ShareStatus.error,
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
    final imagePath = '${tempDir.path}/temp_image.jpg';
    final file = File(imagePath);

    await file.writeAsBytes(imageData);
    return imagePath;
  }

  void resetState() {
    emit(const ShareImageState(status: ShareStatus.initial));
  }
}

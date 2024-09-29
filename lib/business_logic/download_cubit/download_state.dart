part of 'download_cubit.dart';

enum DownloadStatus { initial, downloading, finishedDownloading, error }

class DownloadState extends Equatable {
  final DownloadStatus status;
  final bool isDownloading;

  const DownloadState({
    this.status = DownloadStatus.initial,
    this.isDownloading = false,
  });

  @override
  List<Object> get props => [status, isDownloading];
}

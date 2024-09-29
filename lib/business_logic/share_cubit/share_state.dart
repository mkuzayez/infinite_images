part of 'share_cubit.dart';

enum ShareStatus { initial, sharing, finishedSharing, error }


class ShareImageState extends Equatable {
  final ShareStatus status;

  const ShareImageState({this.status = ShareStatus.initial});

  @override
  List<Object?> get props => [status];
}


final class ShareInitial extends ShareImageState {}




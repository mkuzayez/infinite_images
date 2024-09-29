part of 'slider_bloc.dart';

sealed class SliderEvent extends Equatable {
  const SliderEvent();
}

class FetchSliderTopicsEvent extends SliderEvent {
  @override
  List<Object> get props => [];
}
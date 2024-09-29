import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/slider_bloc/slider_bloc.dart';
import 'package:http_bloc_task2/view/widgets/preview_image_widget.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SliderBloc, SliderState>(
      builder: (context, state) {
        if (state.topics.isNotEmpty) {
          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: [
              for (var topic in state.topics) PreviewImageWidget(topic: topic)
            ],
          );
        } else {
          return const SizedBox(
            height: 100,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';

class PreviewImageWidget extends StatelessWidget {
  final TopicObject topic;
  const PreviewImageWidget({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed('/topic', arguments: topic),
      child: Stack(
        children: [
          if (topic.previewImages != null && topic.title != null)
            BlurHash(
              hash: topic.previewImages!.first.blurHash!,
              imageFit: BoxFit.cover,
              curve: Curves.easeInOut,
            ),
          Image.network(
            topic.previewImages!.first.urls!.regular ??
                topic.previewImages!.first.urls!.full ??
                'https://via.placeholder.com/1000',
            fit: BoxFit.cover,
            width: 1000,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              color: Colors.black54,
              child: Text(
                textAlign: TextAlign.center,
                topic.title!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'SF',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

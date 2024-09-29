import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http_bloc_task2/business_logic/topic_images_bloc/topic_images_bloc.dart';
import 'package:http_bloc_task2/data/models/topic/topic_model.dart';
import 'package:http_bloc_task2/view/widgets/image_widget.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({super.key, required this.topic});

  final TopicObject topic;

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  @override
  void initState() {
    super.initState();
    final topicImagesBloc = BlocProvider.of<TopicImagesBloc>(context);
    topicImagesBloc.add(ClearTopicImagesEvent());
    topicImagesBloc.add(FetchTopicImagesEvent(widget.topic.slug!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title ?? 'Topic'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopicImagesBloc, TopicImagesState>(
          builder: (context, state) {
            print("topic screens state ${state.status}");
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else if (state.status == Status.topicImagesLoaded) {
              return ListView.builder(
                itemCount: state.topicImages.length,
                itemBuilder: (context, index) {
                  final image = state.topicImages[index];
                  final aspectRatio = image.width! / image.height!;
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: MediaQuery.of(context).size.width / aspectRatio,
                    child: ImageWidget(image: image),
                  );
                },
              );
            } else if (state.status == Status.failure) {
              return const Center(
                child: Text(
                  'Error',
                ),
              );
            } else {
              return const Center(
                child: Text(
                  'No images available.',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

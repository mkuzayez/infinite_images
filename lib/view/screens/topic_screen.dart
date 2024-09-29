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
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final topicImagesBloc = BlocProvider.of<TopicImagesBloc>(context);
    topicImagesBloc.add(ClearTopicImagesEvent());
    topicImagesBloc.add(FetchTopicImagesEvent(widget.topic.slug!));

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context
          .read<TopicImagesBloc>()
          .add(FetchMoreTopicImagesEvent(widget.topic.slug!));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
            if (state.status == Status.loading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            } else if (state.topicImages.isNotEmpty) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: state.topicImages.length +
                    (state.status == Status.loadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.topicImages.length) {
                    final image = state.topicImages[index];
                    final aspectRatio = image.width! / image.height!;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height:
                          MediaQuery.of(context).size.width / aspectRatio,
                      child: ImageWidget(image: image),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
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

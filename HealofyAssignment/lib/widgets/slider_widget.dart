import 'package:flutter/material.dart';
import '../widgets/video_widget.dart';

class SlidesWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const SlidesWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final contents = List<Map<String, dynamic>>.from(item['contents'] ?? []);
    if (contents.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: contents.map((c) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: c['mediaType'] == 'IMAGE'
                      ? Image.network(
                          c['url'],
                          fit: BoxFit.contain,
                          loadingBuilder: (ctx, child, progress) =>
                              progress == null
                              ? child
                              : const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                        )
                      : VideoWidget(videoUrl: c['url']),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

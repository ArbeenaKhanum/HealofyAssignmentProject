import 'package:flutter/material.dart';
import '../widgets/video_widget.dart';

class VideoReviewsWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const VideoReviewsWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reviews = List<Map<String, dynamic>>.from(item['videoReviews'] ?? []);
    if (reviews.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((item['title'] ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(item['title'], style: theme.textTheme.titleLarge),
            ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: reviews.map((review) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: SizedBox(
                    width: 180,
                    child: VideoWidget(videoUrl: review['url']),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

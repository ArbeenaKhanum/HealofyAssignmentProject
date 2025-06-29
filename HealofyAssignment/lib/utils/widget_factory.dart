import 'package:flutter/material.dart';
import '../model/content_model.dart';
import '../widgets/side_scroll_widget.dart';
import '../widgets/single_widget.dart';
import '../widgets/slider_widget.dart';
import '../widgets/video_widget.dart';
import '../widgets/videos_reviews_widget.dart';

class ContentWidgetFactory {
  static Widget build(ContentModel content) {
    switch (content.type) {
      case 'CAP_TOP_VIDEO':
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoWidget(videoUrl: content.item['url'] ?? ''),
          ),
        );
      case 'CAP_IMAGE':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              content.item['url'] ?? '',
              fit: BoxFit.fill,
              alignment: Alignment.topLeft,
            ),
          ),
        );

      case 'CAP_SIDE_SCROLL':
        return SideScrollWidget(item: content.item);
      case 'CAP_SLIDES':
        return SlidesWidget(item: content.item);
      case 'CAP_SINGLE':
        return SingleWidget(item: content.item);
      case 'VIDEO_REVIEWS':
        return VideoReviewsWidget(item: content.item);
      default:
        return Text("Unknown content type: ${content.type}");
    }
  }
}

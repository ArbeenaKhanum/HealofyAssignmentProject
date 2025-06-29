import 'package:flutter/material.dart';
import '../widgets/video_widget.dart';

class SingleWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const SingleWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isDark =
        (item['background'] ?? '').toString().toUpperCase() == 'DARK';
    final backgroundColor = isDark
        ? const Color(0xFFF4F8F8)
        : const Color(0xFFFFFFFF); // theme colors

    final url = item['url'] ?? '';
    final title = item['title'] ?? '';
    final subTitle = item['subTitle'] ?? '';

    final media = item['mediaType'] == 'IMAGE'
        ? ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              url,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                );
              },
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: VideoWidget(videoUrl: url),
          );

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: const Color(0xFF164445), // title color
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          if (subTitle.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF000000), // subtitle color
                ),
              ),
            ),
          media,
        ],
      ),
    );
  }
}

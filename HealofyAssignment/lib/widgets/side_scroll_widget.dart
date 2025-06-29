import 'package:flutter/material.dart';
import '../widgets/video_widget.dart';

class SideScrollWidget extends StatelessWidget {
  final Map<String, dynamic> item;

  const SideScrollWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final contents = List<Map<String, dynamic>>.from(item['contents'] ?? []);
    if (contents.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if ((item['title'] ?? '').isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
              child: Text(item['title'], style: theme.textTheme.headlineSmall),
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: contents.map((c) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 200),
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
        ],
      ),
    );
  }
}

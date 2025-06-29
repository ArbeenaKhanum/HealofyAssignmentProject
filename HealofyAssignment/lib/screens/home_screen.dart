import 'package:flutter/material.dart';
import '../model/content_model.dart';
import '../services/api_service.dart';
import '../utils/widget_factory.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: FutureBuilder<List<ContentModel>>(
          future: ApiService.fetchContents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                ),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  'No content available',
                  style: theme.textTheme.bodyMedium,
                ),
              );
            }

            final contents = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: contents.length,
              itemBuilder: (context, index) {
                final content = contents[index];
                final widget = ContentWidgetFactory.build(content);

                if (content.type == 'CAP_SINGLE') {
                  return Container(
                    color: const Color(0xFFF4F8F8),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: widget,
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: widget,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

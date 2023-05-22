import 'package:flutter/material.dart';
import 'package:cap/models/news_feed.dart';

class NewsFeedList extends StatelessWidget {
  final List<NewsFeed> newsFeeds;

  const NewsFeedList({super.key, required this.newsFeeds});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsFeeds.length,
      itemBuilder: (context, index) {
        final newsFeed = newsFeeds[index];
        return Card(
          child: Column(
            children: [
              // ignore: unnecessary_null_comparison
              if (newsFeed.imageUrl != null) Image.network(newsFeed.imageUrl),
              ListTile(
                title: Text(newsFeed.title),
                subtitle: Text(newsFeed.content),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // TODO: Implement delete news feed functionality
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

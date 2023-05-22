import 'package:flutter/material.dart';
import 'package:cap/models/notice.dart';

class NoticeList extends StatelessWidget {
  final List<Notice> notices;

  const NoticeList({super.key, required this.notices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notices.length,
      itemBuilder: (context, index) {
        final notice = notices[index];
        return ListTile(
          leading: const Icon(Icons.picture_as_pdf),
          title: Text(notice.title),
          subtitle: Text(notice.date.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO: Implement delete notice functionality
            },
          ),
        );
      },
    );
  }
}

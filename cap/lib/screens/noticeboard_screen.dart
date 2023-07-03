import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pdf_widgets;

class Notice {
  final String title;
  final DateTime publicationDateTime;
  final String description;
  final File file;

  Notice({
    required this.title,
    required this.publicationDateTime,
    required this.description,
    required this.file,
  });
}

class NoticeboardScreen extends StatefulWidget {
  const NoticeboardScreen({super.key});

  @override
  _NoticeboardScreenState createState() => _NoticeboardScreenState();
}

class _NoticeboardScreenState extends State<NoticeboardScreen> {
  List<Notice> notices = [];

  File? _selectedFile;
  Notice? _selectedNotice;

  Future<void> _pickImageOrPdf() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _addNotice() async {
    if (_selectedFile == null) {
      return;
    }

    final Notice notice = Notice(
      title: 'Sample Notice',
      publicationDateTime: DateTime.now(),
      description: 'This is a sample notice.',
      file: _selectedFile!,
    );

    setState(() {
      notices.add(notice);
      _selectedFile = null;
    });
  }

  Widget _buildNoticeCard(Notice notice) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedNotice = notice;
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: _selectedNotice == notice ? Colors.purple.shade100 : null,
        child: ListTile(
          leading: SizedBox(
            width: 60,
            height: 60,
            child: _getThumbnailWidget(notice.file),
          ),
          title: Text(notice.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Publication Time: ${notice.publicationDateTime.toString()}',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'Description: ${notice.description}',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getThumbnailWidget(File file) {
    if (file.path.toLowerCase().endsWith('.pdf')) {
      return FutureBuilder<pdf_widgets.Document>(
        future: _generatePdfThumbnail(file),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            final pdf_widgets.Document document = snapshot.data!;
            return Image.memory(
              document.save() as Uint8List,
              fit: BoxFit.cover,
            );
          }
          return const CircularProgressIndicator();
        },
      );
    } else {
      return Image.file(
        file,
        fit: BoxFit.cover,
      );
    }
  }

  Future<pdf_widgets.Document> _generatePdfThumbnail(File file) async {
    final pdf_widgets.Document pdf = pdf_widgets.Document();
    final pdf_widgets.Page page = pdf_widgets.Page(
      build: (context) {
        return pdf_widgets.Center(
          child: pdf_widgets.Text('PDF Thumbnail'),
        );
      },
    );
    pdf.addPage(page);
    return pdf;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Noticeboard'),
      ),
      body: Row(
        children: [
          /* Container(
            color: Colors.purple.shade300,
            width: 200, // Adjust the width of the notice list as needed
            child: ListView.builder(
              itemCount: notices.length,
              itemBuilder: (context, index) {
                final notice = notices[index];
                return _buildNoticeCard(notice);
            
              },
            ),

          ),*/
          Container(
            color: Colors.purple.shade300,
            width: 200, // Adjust the width of the notice list as needed
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Notice List',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 2.0,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notices.length,
                    itemBuilder: (context, index) {
                      final notice = notices[index];
                      return _buildNoticeCard(notice);
                    },
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 2.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2, // Adjust the flex of the card preview as needed
            child: Card(
              color: Colors.purple.shade100,
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: _selectedNotice != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _getThumbnailWidget(_selectedNotice!.file),
                          const SizedBox(height: 16),
                          Text(
                            'Title: ${_selectedNotice!.title}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Publication Time: ${_selectedNotice!.publicationDateTime.toString()}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Description: ${_selectedNotice!.description}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Handle button click
                            },
                            child: const Text('Save Notice'),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          'Select a notice to view details',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _pickImageOrPdf,
        child: const Icon(Icons.add),
      ),
    );
  }
}

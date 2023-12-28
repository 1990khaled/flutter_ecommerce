import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
import '../../../models/news_modle.dart';
import '../../../services/firestore_services.dart';

class NewsEditingPage extends StatefulWidget {
  final String newsId;

  const NewsEditingPage({super.key, required this.newsId});

  @override
  State<NewsEditingPage> createState() => _NewsEditingPageState();
}

class _NewsEditingPageState extends State<NewsEditingPage> {
  late TextEditingController _titleController;
  late TextEditingController _imgUrlController;
  late TextEditingController _urlController;
  String? _title;
  String? _imgUrl;
  String? _url;
  @override
  void initState() {
    super.initState();
    // Initialize the controllers with fetched data when the page initializes
    _titleController = TextEditingController(text: _title ?? '');
    _imgUrlController = TextEditingController(text: _imgUrl ?? '');
    _urlController = TextEditingController(text: _url ?? '');

    // Fetch the existing data using the newsId when the page initializes
    fetchNewsDetails();
  }

  Future<void> fetchNewsDetails() async {
    // Fetch news details using the provided newsId
    final newsDetails =
        await FirestoreServices.instance.getData(path: "news/${widget.newsId}");

    if (newsDetails != null) {
      setState(() {
        _title = newsDetails['title'] ?? '';
        _imgUrl = newsDetails['imgUrl'] ?? '';
        _url = newsDetails['url'] ?? '';

        // Update controllers with new data
        _titleController.text = _title ?? '';
        _imgUrlController.text = _imgUrl ?? '';
        _urlController.text = _url ?? '';
      });
    }
  }

  bool _updating = false;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit News'),
      ),
      body: _updating
          ? const Center(
              child:
                  CircularProgressIndicator(), // Display CircularProgressIndicator while updating
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _titleController,
                      decoration:
                          const InputDecoration(labelText: 'Edit Title'),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _imgUrlController,
                      decoration:
                          const InputDecoration(labelText: 'Edit Image URL'),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _urlController,
                      decoration: const InputDecoration(labelText: 'Edit URL'),
                    ),
                  ),
                  const SizedBox(height: 50),
                  ElevatedButton(
                    onPressed: () async {
                      bool result =
                          await InternetConnectionChecker().hasConnection;
                      if (result == true) {
                        setState(() {
                          _updating = true; // Show CircularProgressIndicator
                        });

                        final NewsModel updatedNews = NewsModel(
                          id: widget.newsId,
                          title: _titleController.text,
                          imgUrl: _imgUrlController.text,
                          url: _urlController.text,
                        );

                        try {
                          await database.updateNews(updatedNews);
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        } catch (e) {
                          // Handle Firestore update errors
                          debugPrint("Firestore update error: $e");
                          setState(() {
                            _updating =
                                false; // Hide CircularProgressIndicator on error
                          });
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'تفقد الاتصال بالانترنت',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Save Changes'),
                  ),
                ],
              ),
            ),
    );
  }
}

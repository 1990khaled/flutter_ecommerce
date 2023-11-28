import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
import '../../../models/news_modle.dart';
import '../../../services/firestore_services.dart';

class NewsEditingPage extends StatefulWidget {
  final String newsId;

  const NewsEditingPage({Key? key, required this.newsId}) : super(key: key);

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
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Edit Title'),
                  ),
                  TextFormField(
                    controller: _imgUrlController,
                    decoration:
                        const InputDecoration(labelText: 'Edit Image URL'),
                  ),
                  TextFormField(
                    controller: _urlController,
                    decoration: const InputDecoration(labelText: 'Edit URL'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
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
                        // Update Firestore data
                        await database.updateNews(updatedNews);
                        debugPrint(
                            "${updatedNews.title} ---------------------------------------------------");

                        // Navigate back after successful update
                        Navigator.pop(context);
                      } catch (e) {
                        // Handle Firestore update errors
                        debugPrint("Firestore update error: $e");
                        setState(() {
                          _updating =
                              false; // Hide CircularProgressIndicator on error
                        });
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


// class _NewsEditingPageState extends State<NewsEditingPage> {
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _imgUrlController = TextEditingController();
//   final TextEditingController _urlController = TextEditingController();
//   String? _title;
//   String? _imgUrl;
//   String? _url;

//   @override
//   void initState() {
//     super.initState();
//     // Fetch the existing data using the newsId when the page initializes
//     fetchNewsDetails();
//   }

//   Future<void> fetchNewsDetails() async {
//     // Fetch news details using the provided newsId
//     final newsDetails =
//         await FirestoreServices.instance.getData(path: "news/${widget.newsId}");

//     if (newsDetails != null) {
//       setState(() {
//         _title = newsDetails['title'] ?? '';
//         _imgUrl = newsDetails['imgUrl'] ?? '';
//         _url = newsDetails['url'] ?? '';
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final database = Provider.of<Database>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Edit News'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(
//               child: TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: 'Edit Title'),
//               ),
//             ),
//             SizedBox(
//               child: TextFormField(
//                 controller: _imgUrlController,
//                 decoration: const InputDecoration(labelText: 'Edit Image URL'),
//               ),
//             ),
//             SizedBox(
//               child: TextFormField(
//                 controller: _urlController,
//                 decoration: const InputDecoration(labelText: 'Edit URL'),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 final NewsModel updatedNews = NewsModel(
//                   id: widget.newsId,
//                   title: _titleController.text,
//                   imgUrl: _imgUrlController.text,
//                   url: _urlController.text,
//                 );

//                 try {
//                   // Update Firestore data
//                   await database.updateNews(updatedNews);
//                   debugPrint(
//                       "${updatedNews.title} ---------------------------------------------------");
//                 } catch (e) {
//                   // Handle Firestore update errors
//                   debugPrint("Firestore update error: $e");
//                 }
//               },
//               child: const Text('Save Changes'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/news_modle.dart';

class ListItemNews extends StatefulWidget {
  final NewsModel newsModel;

  const ListItemNews({
    Key? key,
    required this.newsModel,
  }) : super(key: key);

  @override
  State<ListItemNews> createState() => _ListItemNewsState();
}

class _ListItemNewsState extends State<ListItemNews> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        InkWell(
          onTap: _launchURL,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Placeholder(
              child: Image.network(
                widget.newsModel.imgUrl,
                width: size.height * 0.20,
                height: size.height * 0.18,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
            height: size.height * 0.04,
            width: size.height * 0.20,
            child: Text(
              widget.newsModel.title,
              maxLines: 1,
              softWrap: true,
              textAlign: TextAlign.center,
            )),
      ],
    );
  }

  Future _launchURL() async {
    Uri url = Uri.parse(widget.newsModel.url);
    if (await launchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

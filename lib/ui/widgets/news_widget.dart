import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/NewsResponse.dart';
import '../../providers/my_provider.dart';
import '../../providers/search_provider.dart';

class NewsWidget extends StatefulWidget {
  News news;
  int index;
  NewsWidget(this.news, this.index, {super.key});

  @override
  State<NewsWidget> createState() => _NewsWidgetState();
}

class _NewsWidgetState extends State<NewsWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var provider1 = Provider.of<SearchProvider>(context);
    return ChangeNotifierProvider(
        create: (context) => MyProvider(),
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: InkWell(
              onTap: () {
                provider.fromNewsToFull();
                provider1.unViewSearchIcon();
                provider1.unViewSearchBar();

                provider.getNews(widget.news, widget.index);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      imageUrl: widget.news.urlToImage ?? " ",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                              child: CircularProgressIndicator(
                                  value: downloadProgress.progress)),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Text(
                    widget.news.author ?? "",
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    widget.news.title ?? "",
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    widget.news.publishedAt?.substring(0, 10) ?? "",
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

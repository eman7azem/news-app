import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../models/SourcesResponse.dart';
import '../../providers/my_provider.dart';
import '../../providers/search_provider.dart';
import '../../shared/api_manager/api_manager.dart';
import 'news_widget.dart';

class NewsListWidget extends StatelessWidget {
  final Sources source;
  const NewsListWidget(this.source, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    provider.searchedItem ??= "";
    return FutureBuilder(
      future: ApiManager.getInstance()
          .getNews(source.id!, provider.searchedItem ?? ""),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data?.status == "error") {
          return ChangeNotifierProvider(
              create: (context) => MyProvider(),
              builder: (context, child) {
                return Column(
                  children: [
                    Center(
                      child: Text(snapshot.data?.message ??
                          snapshot.data!.status.toString()),
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: const Text("Please try again"))
                  ],
                );
              });
        }

        var news = snapshot.data?.articles ?? [];

        return Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return NewsWidget(news[index], index);
            },
            itemCount: news.length,
          ),
        );
      },
    );
  }
}

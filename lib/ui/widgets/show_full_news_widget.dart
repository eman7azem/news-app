import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/my_provider.dart';
import '../../providers/search_provider.dart';
import '../../shared/api_manager/api_manager.dart';

class ShowFullNewWidget extends StatelessWidget {
  const ShowFullNewWidget({super.key});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    var provider2 = Provider.of<SearchProvider>(context);

    return ChangeNotifierProvider(
        create: (context) => MyProvider(),
        builder: (context, child) => FutureBuilder(
            future: ApiManager.getInstance().getNews(
                provider.newsItem.source!.id!, provider2.searchedItem ?? ""),
            builder: (context, snapshot) {
              provider2.searchedItem ??= "";
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError ||
                  snapshot.data?.status == "error") {
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
              }

              var news = snapshot.data?.articles ?? [];
              int index = provider.newsIndex;
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: CachedNetworkImage(
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: news[index].urlToImage ?? " ",
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                    value: downloadProgress.progress)),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(news[index].source?.name ?? "",
                        style: const TextStyle(
                            fontSize: 10, color: Color(0xFF79828B))),
                    const SizedBox(height: 5),
                    Text(news[index].title ?? "",
                        style:
                            const TextStyle(fontSize: 14, color: Colors.black)),
                    const SizedBox(height: 5),
                    Text(news[index].publishedAt?.substring(0, 10) ?? "",
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontSize: 13, color: Color(0xFF79828B))),
                    const SizedBox(height: 50),
                    Text(news[index].description ?? "",
                        style:
                            const TextStyle(fontSize: 13, color: Colors.black)),
                    const SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        provider.fromFullToNews();
                        provider2.viewSearchIcon();
                        if (provider2.searchBar == false) {
                          provider2.unViewSearchBar();
                        } else {
                          provider2.viewSearchBar();
                        }
                      },
                      child: const Align(
                          alignment: Alignment.bottomLeft,
                          child: Icon(Icons.arrow_back)),
                    ),
                    InkWell(
                        onTap: () async {
                          final Uri url = Uri.parse(news[index].url ?? "");

                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch');
                          }
                        },
                        child: const Text(
                            textAlign: TextAlign.end,
                            "View Full Article",
                            style: TextStyle(fontSize: 14)))
                  ],
                ),
              );
            }));
  }
}

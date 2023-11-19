import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/search_provider.dart';
import '../categories/categories_widget.dart';
import '../categories/category.dart';
import '../categories/category_details.dart';
import '../settings/settings_widget.dart';
import 'home_drawer.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = "HomeLayout";
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  @override
  void initState() {
    super.initState();
    selectedWidget = CategoriesWidget(onCategoryClicked);
  }

  // bool searchSelected = false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SearchProvider>(context);
    provider.searchBar ??= false;
    late var searchController = TextEditingController();
    searchController.text = provider.searchedItem ?? "";

    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/images/pattern.png"),
              fit: BoxFit.cover)),
      child: WillPopScope(
        onWillPop: () {
          if (selectedWidget is CategoriesWidget) {
            return Future.value(true);
          } else if (selectedWidget is CategoryDetails) {
            selectedWidget = CategoriesWidget(onCategoryClicked);
            setState(() {});
            provider.unViewSearchIcon();
            return Future.value(false);
          }
          return Future.value(false);
        },
        child: Scaffold(
          drawer: HomeDrawer(onMenuItemClicked),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(35),
            )),
            elevation: 4,
            backgroundColor: Colors.green,
            centerTitle: true,
            title: provider.searchBar == true
                ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    // padding: const EdgeInsets.only(right: 10),
                    height: 38,
                    child: SearchBar(
                      onSubmitted: (value) {
                        provider.searchNews(value);
                      },
                      // hintText: "search",
                      leading: const Icon(Icons.search, color: Colors.black),
                      trailing: [
                        Tooltip(
                          message: 'Change brightness mode',
                          child: IconButton(
                            onPressed: () {
                              provider.searchNews("");
                              provider.unViewSearchBar();
                            },
                            icon: const Icon(Icons.cancel, color: Colors.black),
                          ),
                        )
                      ],
                      controller: searchController,
                    ))
                : Row(
                    children: [
                      Text("News App".tr()),
                      const Spacer(),
                      provider.showSearchIcon == true
                          ? InkWell(
                              onTap: () {
                                provider.viewSearchBar();
                              },
                              child: const Icon(Icons.search))
                          : const SizedBox()
                    ],
                  ),
          ),
          body: selectedWidget,

          // body:
        ),
      ),
    );
  }

  late Widget selectedWidget;

  void onMenuItemClicked(MenuItem item) {
    if (item == MenuItem.settings) {
      selectedWidget = const SettingsWidget();
    } else {
      selectedWidget = CategoriesWidget(onCategoryClicked);
    }
    setState(() {});
  }

  void onCategoryClicked(Category category) {
    selectedWidget = CategoryDetails(category);
    setState(() {});
  }
}

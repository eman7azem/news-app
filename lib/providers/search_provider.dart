import 'package:flutter/cupertino.dart';

class SearchProvider extends ChangeNotifier {
  String? searchedItem;
  bool? showSearchIcon;
  bool? searchBar;

  searchNews(String keyword) {
    searchedItem ??= "";
    searchedItem = keyword;
    notifyListeners();
  }

  viewSearchIcon() {
    showSearchIcon = true;
    notifyListeners();
  }

  unViewSearchIcon() {
    showSearchIcon = false;
    notifyListeners();
  }

  viewSearchBar() {
    searchBar = true;
    notifyListeners();
  }

  unViewSearchBar() {
    searchBar = false;
    notifyListeners();
  }
}

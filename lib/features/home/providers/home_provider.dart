import 'package:flutter/material.dart';
import 'package:thedailynews/data/models/breaking_news_model.dart';
import 'package:thedailynews/data/services/breaking_news_service.dart';

class HomeProvider extends ChangeNotifier {
  final BreakingNewsService _breakingNewsService;

  BreakingNewsModel? _breakingNews;
  bool _isLoading = false;
  String? _error;

  HomeProvider(this._breakingNewsService);

  BreakingNewsModel? get breakingNews => _breakingNews;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get filtered categories excluding Star Multimedia
  Map<String, List<Headline>> get filteredCategories {
    if (_breakingNews == null) return {};

    final categories = Map<String, List<Headline>>.from(
      _breakingNews!.data.categories,
    );
    categories.remove('Star Multimedia');
    return categories;
  }

  Future<void> fetchBreakingNews() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _breakingNews = await _breakingNewsService.getBreakingNews();

      _isLoading = false;
      notifyListeners();
      debugPrint(
        'Breaking News: ${_breakingNews?.data.headlines.length} articles fetched',
      );
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}

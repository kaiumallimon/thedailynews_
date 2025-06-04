import 'package:flutter/material.dart';
import 'package:thedailynews/data/models/news_category_model.dart';
import 'package:thedailynews/data/services/category_services.dart';

class NewsCategoryProvider extends ChangeNotifier{

  final CategoryServices _categoryServices;

  NewsCategoryProvider(this._categoryServices);

  NewsCategoryResponse? _newsCategoryResponse;
  bool _isLoading = false;
  String? _error;

  NewsCategoryResponse? get newsCategoryResponse => _newsCategoryResponse;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchNewsCategories() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final response = await _categoryServices.getCategories();
      _newsCategoryResponse = response;

      _isLoading = false;
      notifyListeners();
      debugPrint(
        'News Categories: ${_newsCategoryResponse?.categories.length} categories fetched',
      );
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }
}
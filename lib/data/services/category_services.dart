import 'package:dio/dio.dart';
import 'package:thedailynews/core/network/dio_client.dart';
import 'package:thedailynews/data/models/news_category_model.dart';

class CategoryServices {
  final DioClient _dioClient;

  CategoryServices(this._dioClient);

  Future<NewsCategoryResponse> getCategories() async {
    try {
      final response = await _dioClient.get('/categories');
      return NewsCategoryResponse.fromJson(response.data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to fetch breaking news: $e');
    }
  }
}
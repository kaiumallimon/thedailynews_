import 'package:dio/dio.dart';
import 'package:thedailynews/core/network/dio_client.dart';
import 'package:thedailynews/data/models/breaking_news_model.dart';

class BreakingNewsService {
  final DioClient _dioClient;

  BreakingNewsService(this._dioClient);

  Future<BreakingNewsModel> getBreakingNews() async {
    try {
      final response = await _dioClient.get('/breaking');
      return BreakingNewsModel.fromJson(response.data);
    } on DioException {
      rethrow;
    } catch (e) {
      throw Exception('Failed to fetch breaking news: $e');
    }
  }
}

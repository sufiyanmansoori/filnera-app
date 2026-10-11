import 'package:filnera/data/models/product_model.dart';

import '../../../../core/network/api_client.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/deal_model.dart';

class HomeRepository {
  final ApiClient _apiClient;

  HomeRepository({required this._apiClient});

  Future<Map<String, dynamic>> fetchHome() async {
    try {
      final response = await _apiClient.get('/home');
      final data = response.data;

      return {
        'banners':
            (data['banners'] as List?)
                ?.map((e) => BannerModel.fromJson(e))
                .toList() ??
            [],
        'categories':
            (data['categories'] as List?)
                ?.map((e) => CategoryModel.fromJson(e))
                .toList() ??
            [],
        'deals':
            (data['deals'] as List?)
                ?.map((e) => DealModel.fromJson(e))
                .toList() ??
            [],
        'featuredProducts':
            (data['featuredProducts'] as List?)
                ?.map((e) => ProductModel.fromJson(e))
                .toList() ??
            [],
      };
    } catch (e) {
      rethrow;
    }
  }
}

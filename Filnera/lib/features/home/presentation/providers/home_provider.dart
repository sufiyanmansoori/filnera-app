import 'package:flutter/foundation.dart';
import 'package:filnera/data/models/product_model.dart';

class HomeProvider extends ChangeNotifier {
  final dynamic _repository;

  List<BannerModel> _banners = [];
  List<CategoryModel> _categories = [];
  List<DealModel> _deals = [];
  List<ProductModel> _featuredProducts = [];
  bool _isLoading = false;
  String? _errorMessage;

  HomeProvider({required this._repository});

  List<BannerModel> get banners => _banners;
  List<CategoryModel> get categories => _categories;
  List<DealModel> get deals => _deals;
  List<ProductModel> get featuredProducts => _featuredProducts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchHome() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      if (kDebugMode) {
        print('🔄 HomeProvider: Fetching home data...');
      }

      final data = await _repository.fetchHome();

      _banners = data['banners'] ?? [];
      _categories = data['categories'] ?? [];
      _deals = data['deals'] ?? [];
      _featuredProducts = data['featuredProducts'] ?? [];

      if (kDebugMode) {
        print(
          '✅ HomeProvider: Loaded ${_banners.length} banners, ${_categories.length} categories, ${_deals.length} deals, ${_featuredProducts.length} products',
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      if (kDebugMode) {
        print('❌ HomeProvider Error: $e');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}

class DealModel {
  String? get productName => null;

  Null get productImage => null;

  // ignore: strict_top_level_inference, body_might_complete_normally_nullable
  static Object? fromJson(e) {}
}

class CategoryModel {
  String? get name => null;

  Null get imageUrl => null;

  // ignore: strict_top_level_inference, body_might_complete_normally_nullable
  static Object? fromJson(e) {}
}

class BannerModel {
  String? get imageUrl => null;

  // ignore: strict_top_level_inference, body_might_complete_normally_nullable
  static Object? fromJson(e) {}
}

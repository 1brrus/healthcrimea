import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _items = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Product> get items => _items;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final _supabase = Supabase.instance.client;

  Future<void> fetchItems() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final List<Map<String, dynamic>> response = await _supabase
          .from('products')
          .select();

      _items = response.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      _errorMessage = 'Не удалось загрузить данные из Supabase: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(String name, String description, String number) async {
    try {
      await _supabase.from('products').insert({
        'name': name,
        'description': description,
        'number': number,
      });

      await fetchItems();
    } catch (e) {
      _errorMessage = 'Не удалось добавить товар: $e';
      notifyListeners();
    }
  }
}

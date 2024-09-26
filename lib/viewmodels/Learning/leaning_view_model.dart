import 'package:flutter/material.dart';
import 'package:plu_trainer/services/supabase_service.dart';
import 'package:plu_trainer/models/products_model.dart';

class LeaningViewModel extends ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  List<bool> visibilityFlags = [];
  List<String> _letters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<String> get letters => _letters;

  // Método para obtener productos por letra inicial
  Future<void> fetchProductsByLetter(String letter) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Llamada al servicio que obtiene los productos que empiezan con una letra específica
      _products = await _supabaseService.fetchProductsByLetter(letter);

      // Inicializa las flags de visibilidad
      visibilityFlags = List.generate(_products.length, (index) => true);

      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error fetching products: $e';
      _products = [];
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plu_trainer/models/products_model.dart';
import 'package:plu_trainer/services/supabase_service.dart';

class PLUListStopWatchViewModel extends ChangeNotifier {
  final SupabaseService _service = SupabaseService();
  List<Product> _products = [];
  bool _isLoading = false;
  String? _errorMessage;
  // ignore: prefer_final_fields
  List<bool> _results = [];
  int _currentIndex = 0;
  List<bool> _visibilityFlags = [];
  final ScrollController _scrollController = ScrollController();
  double _pluListTextHeight = 0;

  ScrollController get scrollController => _scrollController;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<bool> get results => _results;
  int get currentIndex => _currentIndex;
  List<bool> get visibilityFlags => _visibilityFlags;

  Future<void> fetchRandomMoreProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _service.fetchRandomMoreProducts();
      _errorMessage = null;
      _results.clear();
      _currentIndex = 0;
      _initializeVisibilityFlags();
      _startAnimationSequence();
    } catch (e) {
      _errorMessage = 'Error getting products: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _initializeVisibilityFlags() {
    _visibilityFlags = List<bool>.filled(_products.length, false);
  }

  void _startAnimationSequence() {
    for (int i = 0; i < _visibilityFlags.length; i++) {
      Timer(Duration(milliseconds: i * 200), () {
        _visibilityFlags[i] = true;
        notifyListeners();
      });
    }
  }

  void checkPLU(String pluStr) {
    int enteredPlu = int.tryParse(pluStr) ?? -1;

    if (enteredPlu == _products[_currentIndex].plu) {
      _results.add(true);
    } else {
      _results.add(false);
    }

    _currentIndex++;
    notifyListeners();
  }

  void scrollToNextItem() {
    if (_scrollController.hasClients && _pluListTextHeight > 0) {
      _scrollController.animateTo(
        _scrollController.offset + _pluListTextHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void calculateHeight(BuildContext context, GlobalKey key) {
    final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      _pluListTextHeight = box.size.height;
    }
  }

  bool hasMoreProducts() {
    return _currentIndex < _products.length;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

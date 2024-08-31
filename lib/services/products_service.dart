import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:plu_trainer/models/products_model.dart';
import 'package:logger/logger.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;
  final Logger _logger = Logger();

  Future<List<Product>> fetchRandomProducts() async {
    final response = await _client.rpc('get_random_products').select();

    if (response != null) {
      _logger.d('Recovered Products: $response');
      return (response as List)
          .map((json) => Product.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      _logger.e('Error: No products were found.');
      throw Exception('No products were obtained.');
    }
  }
}

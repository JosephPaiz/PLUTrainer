import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:plu_trainer/models/products_model.dart';
import 'package:logger/logger.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;
  final Logger _logger = Logger();

  Future<List<Product>> fetchRandomProducts() async {
    final response = await _client.rpc('get_random_products').select();

    // ignore: unnecessary_null_comparison
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

  Future<List<Product>> fetchRandomMoreProducts() async {
    final response = await _client.rpc('get_random_more_products').select();

    // ignore: unnecessary_null_comparison
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

  Future<bool> checkSuperkey(int superkey) async {
    final response = await _client
        .from('profiles')
        .select('superkey')
        .eq('superkey', superkey)
        .maybeSingle();

    if (response == null) {
      _logger.e('Error: Failed to retrieve data.');
      return false;
    }

    // ignore: unnecessary_null_comparison
    final exists = response != null;

    if (exists) {
      _logger.d('Superkey $superkey is valid.');
    } else {
      _logger.w('Superkey $superkey is not found.');
    }

    return exists;
  }

  Future<void> insertHistory(
      int superkey,
      double score,
      int answeredQuestions,
      int correctAnswers,
      int pluHelperUsage,
      String trainingType,
      int duration) async {
    final response = await _client.from('history').insert({
      'superkey': superkey,
      'score': score,
      'answered_questions': answeredQuestions,
      'correct_answers': correctAnswers,
      'pluhelper_usage': pluHelperUsage,
      'training_type': trainingType,
      'duration': duration,
    });

    if (response.error != null) {
      _logger.w('Error inserting into history: ${response.error!.message}');
    } else {
      _logger.d('History inserted successfully');
    }
  }
}

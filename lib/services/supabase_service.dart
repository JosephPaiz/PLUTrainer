import 'package:plu_trainer/models/history_data.dart';
import 'package:plu_trainer/models/history_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:plu_trainer/models/profile_model.dart';
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

  Future<void> insertHistory(HistoryData historyData) async {
    try {
      final recentHistory = await _client
          .from('history')
          .select()
          .eq('superkey', historyData.superKey)
          .eq('training_type', historyData.trainingType)
          .eq('date', historyData.date.toIso8601String().split('.')[0])
          .limit(1)
          .maybeSingle();

      if (recentHistory != null) {
        _logger.w(
            'Se encontró una inserción reciente, omitiendo nueva inserción.');
        return;
      }

      final response =
          await _client.from('history').insert(historyData.toMap()).select();

      if (response != null && response.isNotEmpty) {
        _logger.d('Historia insertada correctamente en Supabase.');
      } else {
        _logger.e('Error insertando la historia.');
      }
    } catch (e) {
      _logger.e('Error al insertar la historia: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getProfilesWithRoles() async {
    final response = await _client.rpc('get_profiles_with_roles').select();
    // ignore: unnecessary_null_comparison
    if (response == null) {
      throw Exception('Error fetching profiles with roles: No data received');
    }

    return List<Map<String, dynamic>>.from(response as List);
  }

  Future<bool> isUserInRole(int superkey, List<int> allowedRoles) async {
    try {
      final response = await _client
          .from('profile_roles')
          .select('role_id')
          .eq('profile_superkey', superkey);

      if (response.isNotEmpty) {
        final userRoles =
            List<int>.from(response.map((item) => item['role_id']));
        return userRoles.any((role) => allowedRoles.contains(role));
      }

      return false;
    } catch (e) {
      _logger.e('Error checking roles: $e');
      return false;
    }
  }

  Future<List<HistoryModel>> fetchHistoryBySuperkey(int superkey) async {
    try {
      final response = await _client
          .from('history')
          .select(
              'profiles!inner(name), score, answered_questions, correct_answers, pluhelper_usage, duration, date, training_type')
          .eq('superkey', superkey);

      if (response.isNotEmpty) {
        return (response as List)
            .map((data) => HistoryModel.fromMap(data as Map<String, dynamic>))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      _logger.e('Error fetching history: $e');
      throw Exception('Failed to fetch history.');
    }
  }

  Future<ProfileModel?> fetchProfileBySuperkey(int superkey) async {
    try {
      final response = await _client
          .from('profiles')
          .select()
          .eq('superkey', superkey)
          .single();

      // ignore: unnecessary_null_comparison
      if (response != null) {
        return ProfileModel.fromMap(response);
      }
      return null;
    } catch (error) {
      throw Exception('Error fetching profile: $error');
    }
  }

  Future<List<Product>> fetchProductsByLetter(String letter) async {
    try {
      final response = await _client
          .rpc('get_products_by_letter', params: {'letter_input': letter});

      if (response != null && response.isNotEmpty) {
        _logger.d('Productos recuperados: $response');

        return (response as List).map((json) {
          return Product.fromJson(json as Map<String, dynamic>);
        }).toList();
      } else {
        _logger.w(
            'No se encontraron productos que comiencen con la letra: $letter');
        return [];
      }
    } catch (e) {
      _logger.e('Error al obtener productos por letra: $e');
      throw Exception('Error al obtener productos por letra.');
    }
  }
}

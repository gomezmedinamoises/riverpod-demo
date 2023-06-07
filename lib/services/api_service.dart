import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/models/suggestion.dart';

// Se define un Provider que proporciona una instancia de la clase ApiService
final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

// Clase para hacer una solicitud a una API
class ApiService {
  Future<Suggestion> getSuggestion() async {
    try {
      // Se realiza una solicitud a la API y se espera la respuesta
      final res = await Dio().get('https://www.boredapi.com/api/activity');
      // Convierte la respuesta en un objeto de tipo Suggestion utilizando el factory fromJson
      return Suggestion.fromJson(res.data);
    } catch (e) {
      throw Exception('Error getting suggestion');
    }
  }
}

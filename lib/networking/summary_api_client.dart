import 'dart:convert';

import 'package:covid_web/models/models.dart';
import 'package:http/http.dart' as http;

class SummaryApiClient {
  Future<Summary> fetchAllDetails() async {
    final response = await http.get('https://disease.sh/v3/covid-19/all');

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Summary.fromJson(json);
    } else {
      throw Exception('error fetching all details');
    }
  }
}

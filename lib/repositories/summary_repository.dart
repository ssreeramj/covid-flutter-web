import 'package:covid_web/networking/summary_api_client.dart';
import 'package:covid_web/models/models.dart';

class SummaryRepository {
  final SummaryApiClient summaryApiClient;

  SummaryRepository(this.summaryApiClient);

  Future<Summary> fetchAllDetails() async {
    return await summaryApiClient.fetchAllDetails();
  }
}

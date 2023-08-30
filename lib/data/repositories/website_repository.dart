

import 'package:yukla/data/models/universal_data.dart';
import 'package:yukla/data/models/websites/website_model.dart';
import 'package:yukla/data/network/api_service.dart';

class WebsiteRepository {
  final ApiService apiService;

  WebsiteRepository({required this.apiService});

  Future<UniversalData> getWebsites() async => apiService.getWebsites();

  Future<UniversalData> getWebsiteById(int websiteId) async =>
      apiService.getWebsiteById(websiteId);

  Future<UniversalData> createWebsite(WebsiteModel newWebsite) async =>
      apiService.createWebsite(websiteModel: newWebsite);
}

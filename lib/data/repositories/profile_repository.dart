

import 'package:yukla/data/models/universal_data.dart';
import 'package:yukla/data/network/api_service.dart';

class ProfileRepository {
  final ApiService apiService;

  ProfileRepository({required this.apiService});

  Future<UniversalData> getUserData() async => apiService.getProfileData();
}

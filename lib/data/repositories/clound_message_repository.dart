import 'package:yukla/data/models/universal_data.dart';
import 'package:yukla/data/network/api_service.dart';

class CloudMessageRepository {
  CloudMessageRepository({required this.apiService});

  final ApiService apiService;

  Future<UniversalData> sendMessage() async => apiService.sendMessage();
}

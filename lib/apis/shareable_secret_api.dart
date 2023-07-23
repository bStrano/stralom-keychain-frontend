import 'package:keychain_frontend/enum/lifetime_enum.dart';

class ShareableSecretApi {
  ShareableSecretApi._();

  static const String createShareableSecret = '/shareable-secret/create';

  static List<Map<String, dynamic>> getLifetimeOptions(){
    return [
      {
        'label': '1 dia',
        'value': LifetimeEnum.oneDay
      },
      {
        'label': '1 semana',
        'value': LifetimeEnum.oneWeek
      },
      {
        'label': '1 mês',
        'value': LifetimeEnum.oneMonth,
      },
    ];
  }

  static List<Map<String, dynamic>> getViewCountOptions(){
    return [
      {
      'label': '1 visualização',
      'value': 1
      },
      {
      'label': '2 visualizações',
      'value': 2
      },
      {
      'label': '3 visualizações',
      'value': 3
      },

    ];
  }

  static registerShareableSecret(){

  }
}

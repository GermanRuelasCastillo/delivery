import 'package:delivery/src/models/mercado_pago/mercado_pago_credentials.dart';

class Enviroment {
  static const String API_DELIVERY = "192.168.0.2:3000";
  static MercadoPagoCredentials mercadoPagoCredentials = MercadoPagoCredentials(
      publicKey: 'TEST-1cce57fe-1233-4b74-913a-5378a8582ba4',
      accessToken:
          'TEST-7493313499794129-042320-e674a517e066b83432af570eea368dd0-427354191');
}

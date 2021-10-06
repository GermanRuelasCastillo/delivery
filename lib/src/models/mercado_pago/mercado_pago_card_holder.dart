class MercadoPagoCardHolder {
  //NOMBRE
  String name = '';

  //NUMERO DE IDENTIFICACION
  int number = 0;

  //SUBTIPO DE IDENTIFICACION
  String subtype = '';

  //TIPO DE IDENTIFICACION
  String type = '';

  List<MercadoPagoCardHolder> cardHolderList = [];

  MercadoPagoCardHolder();

  MercadoPagoCardHolder.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) {
      return;
    }
    jsonList.forEach((item) {
      final chat = MercadoPagoCardHolder.fromJsonMap(item);
      cardHolderList.add(chat);
    });
  }

  MercadoPagoCardHolder.fromJsonMap(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'] : '';
    number = json['identification'] != null
        ? (json['identification']['number'] != null)
            ? int.parse(json['identification']['number'].toString())
            : 0
        : 0;
    subtype =
        json['identification'] != null ? json['identification']['subtype'] : '';
    type = json['identification'] != null ? json['identification']['type'] : '';
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'number': number,
        'subtype': subtype,
        'type': type,
      };
}

import 'package:delivery/src/models/mercado_pago/mercado_pago_document_type.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/pages/client/payments/create/client_payment_create_controller.dart';
import 'package:delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class ClientPaymentCreatePage extends StatefulWidget {
  ClientPaymentCreatePage({Key? key}) : super(key: key);

  @override
  _ClientPaymentCreatePageState createState() =>
      _ClientPaymentCreatePageState();
}

class _ClientPaymentCreatePageState extends State<ClientPaymentCreatePage> {
  ClientPaymentsCreateController _con = new ClientPaymentsCreateController();
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagos'),
      ),
      body: ListView(
        children: [
          CreditCardWidget(
            onCreditCardWidgetChange: _con.onCreditCardWidgetChanged,
            cardNumber: _con.cardNumber,
            expiryDate: _con.expiryDate,
            cardHolderName: _con.cardHolderName,
            cvvCode: _con.cvvCode,
            showBackView: _con.isCvvFocused,
            cardBgColor: MyColors.primaryColor,
            glassmorphismConfig: Glassmorphism.defaultConfig(),
            // backgroundImage: 'assets/card_bg.png',
            obscureCardNumber: true,
            obscureCardCvv: true,
            isHolderNameVisible: true,
            isChipVisible: true,
            labelCardHolder: 'Nombre y Apellido',
            isSwipeGestureEnabled: true,
            animationDuration: Duration(milliseconds: 1000),
          ),
          CreditCardForm(
            cardNumber: '',
            expiryDate: '',
            cvvCode: '',
            cardHolderName: '',
            formKey: _con.formKey, // Required
            onCreditCardModelChange: _con.onCreditCardModelChanged, // Required
            themeColor: Colors.red,
            obscureCvv: true,
            obscureNumber: true,
            isHolderNameVisible: true,
            isCardNumberVisible: true,
            isExpiryDateVisible: true,
            cardNumberDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Número de la tarjeta',
              hintText: 'XXXX XXXX XXXX XXXX',
            ),
            expiryDateDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Fecha de expiración',
              hintText: 'XX/XX',
            ),
            cvvCodeDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'CVV',
              hintText: 'XXX',
            ),
            cardHolderDecoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre del Titular',
            ),
          ),
          _documentInfo(),
          _buttonNext()
        ],
      ),
    );
  }

  Widget _documentInfo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Material(
              elevation: 2,
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: DropdownButton(
                          underline: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(Icons.arrow_drop_down_circle,
                                color: MyColors.primaryColor),
                          ),
                          elevation: 3,
                          isExpanded: true,
                          hint: Text('Doc',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                          items: _dropdownItems(_con.documentTypeList),
                          value: _con.typeDocument,
                          onChanged: (option) {
                            setState(() {
                              _con.typeDocument = option.toString();
                            });
                          },
                        ),
                      )
                    ],
                  )),
            ),
          ),
          SizedBox(width: 15),
          Flexible(
            flex: 4,
            child: TextField(
                controller: _con.documentNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Número de Documento')),
          )
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>>? _dropdownItems(
      List<MercadoPagoDocumentType> documentType) {
    List<DropdownMenuItem<String>> list = [];
    documentType.forEach((document) {
      list.add(DropdownMenuItem(
        child: Container(
            margin: EdgeInsets.only(top: 7), child: Text(document.name)),
        value: document.id,
      ));
    });
    return list;
  }

  Widget _buttonNext() {
    return Container(
        margin: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: _con.createCardToken,
          style: ElevatedButton.styleFrom(
              primary: MyColors.primaryColor,
              padding: EdgeInsets.symmetric(vertical: 5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text('Continuar',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: 50, top: 6),
                height: 30,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ]),
        ));
  }

  void refresh() {
    setState(() {});
  }
}

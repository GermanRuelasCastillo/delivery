import 'package:delivery/src/models/mercado_pago/mercado_pago_document_type.dart';
import 'package:delivery/src/models/mercado_pago/mercado_pago_installment.dart';
import 'package:delivery/src/models/user.dart';
import 'package:delivery/src/pages/client/payments/installments/client_payment_installments_controller.dart';
import 'package:delivery/src/utils/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class ClientPaymentInstallmentsPage extends StatefulWidget {
  // ClientPaymentCreatePage({Key? key}) : super(key: key);

  @override
  _ClientPaymentInstallmentsPageState createState() =>
      _ClientPaymentInstallmentsPageState();
}

class _ClientPaymentInstallmentsPageState
    extends State<ClientPaymentInstallmentsPage> {
  ClientPaymentsInstallmentsController _con =
      new ClientPaymentsInstallmentsController();
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
        title: Text('Cuotas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_textDescription(), _dropDownInstallments()],
      ),
      bottomNavigationBar: Container(
        height: 140,
        child: Column(
          children: [
            _textTotalPrice(),
            _buttonNext(),
          ],
        ),
      ),
    );
  }

  Widget _textDescription() {
    return Container(
      margin: EdgeInsets.all(30),
      child: Text(
        'En cuantas cuotas?',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _textTotalPrice() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total a pagar:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${_con.totalPayment}',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget _dropDownInstallments() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                    hint: Text('Seleccionar el nro de cuotas',
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    items: _dropdownItems(_con.installmentList),
                    value: _con.selectedInstallment,
                    onChanged: (option) {
                      setState(() {
                        _con.selectedInstallment = option.toString();
                      });
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }

  List<DropdownMenuItem<String>>? _dropdownItems(
      List<MercadoPagoInstallment> installmentList) {
    List<DropdownMenuItem<String>> list = [];
    installmentList.forEach((installment) {
      list.add(DropdownMenuItem(
        child: Container(
            margin: EdgeInsets.only(top: 7),
            child: Text('${installment.installments}')),
        value: '${installment.installments}',
      ));
    });
    return list;
  }

  Widget _buttonNext() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ElevatedButton(
          onPressed: () {},
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
                child: Text('Confirmar Pago',
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
                  Icons.attach_money,
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

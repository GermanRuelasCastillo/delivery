import 'package:delivery/src/pages/client/products/list/client_products_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ClientProducsListPage extends StatefulWidget {
  ClientProducsListPage({Key? key}) : super(key: key);

  @override
  _ClientProducsListPageState createState() => _ClientProducsListPageState();
}

class _ClientProducsListPageState extends State<ClientProducsListPage> {
  ClientProductsListController _controller = new ClientProductsListController();
  @override
  void initState() {
    super.initState();
    _controller.init(context);
    SchedulerBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.init(context);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: _controller.logout,
          child: Text('Cerrar Sesión'),
        ),
      ),
    );
  }
}

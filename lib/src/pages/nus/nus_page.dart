import 'package:flutter/material.dart';
import 'package:nusaramina/src/pages/tabs/actos/actos_tab.dart';
import 'package:nusaramina/src/pages/tabs/correcciones_tab.dart';

class NusPage extends StatefulWidget {
  //Stream<DocumentSnapshot> data2=  Firestore.instance.collection('nus').document('documentoId').snapshots();
  @override
  _NusPageState createState() => _NusPageState();
}

class _NusPageState extends State<NusPage> {
  final tabController = new DefaultTabController(
    length: 2,
    child: new Scaffold(
      appBar: new AppBar(
        title: Text(
          "NUS0001",
          style: TextStyle(color: Colors.white),
        ),
        bottom: new TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.tealAccent,
          tabs: <Widget>[
            Tab(
              icon: Icon(
                Icons.assignment,
              ),
              text: 'Actos/Condiciones',
            ),
            Tab(
              icon: Icon(
                Icons.business_center,
              ),
              text: 'Acciones',
            ),
          ],
        ),
      ),
      body: TabBarView(
        children: <Widget>[
          Actostab(),
          Correctivotab(),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabController,
    );
  }
}

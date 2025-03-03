import 'package:flutter/material.dart';
import 'package:transportation_routes_app/provider/transportation_provider.dart';
import 'package:transportation_routes_app/model/transportation_item.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final routeNameController = TextEditingController();
  final transportTypeController = TextEditingController();
  final distanceController = TextEditingController();
  final costController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('เพิ่มเส้นทางคมนาคม')),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'ชื่อเส้นทาง'),
              controller: routeNameController,
              validator: (value) => value!.isEmpty ? "กรุณาป้อนชื่อเส้นทาง" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'ประเภทการเดินทาง'),
              controller: transportTypeController,
              validator: (value) => value!.isEmpty ? "กรุณาป้อนประเภทการเดินทาง" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'ระยะทาง (กิโลเมตร)'),
              keyboardType: TextInputType.number,
              controller: distanceController,
              validator: (value) => double.tryParse(value!) == null ? "กรุณาป้อนตัวเลข" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'ค่าใช้จ่าย (บาท)'),
              keyboardType: TextInputType.number,
              controller: costController,
              validator: (value) => double.tryParse(value!) == null ? "กรุณาป้อนตัวเลข" : null,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var provider = Provider.of<TransportationProvider>(context, listen: false);
                  provider.addTransportation(
                    TransportationItem(
                      routeName: routeNameController.text,
                      transportType: transportTypeController.text,
                      distance: double.parse(distanceController.text),
                      cost: double.parse(costController.text),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('เพิ่มข้อมูล'),
            ),
          ],
        ),
      ),
    );
  }
}

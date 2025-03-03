import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transportation_routes_app/model/transportation_item.dart';
import 'package:transportation_routes_app/provider/transportation_provider.dart';
import 'form_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TransportationProvider()..initData(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'เส้นทางคมนาคม',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("เส้นทางคมนาคม"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Consumer<TransportationProvider>(
        builder: (context, provider, child) {
          var transportationList = provider.getTransportation();

          if (transportationList.isEmpty) {
            return const Center(
              child: Text(
                "ไม่มีข้อมูลเส้นทางคมนาคม",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: transportationList.length,
            itemBuilder: (context, index) {
              TransportationItem item = transportationList[index];

              return Dismissible(
                key: Key(item.routeName),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  provider.deleteTransportation(item);
                },
                child: Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(
                      item.routeName, // ชื่อเส้นทาง
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" ประเภท: ${item.transportType}", style: TextStyle(color: Colors.black87)),
                        Text(" ระยะทาง: ${item.distance} กม.", style: TextStyle(color: Colors.black87)),
                        Text(" ค่าใช้จ่าย: ${item.cost} บาท", style: TextStyle(color: Colors.green[700])),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        provider.deleteTransportation(item);
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FormScreen()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

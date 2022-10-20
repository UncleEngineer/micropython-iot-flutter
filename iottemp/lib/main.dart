import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'IoT Temp Converter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var censor_ctrl = TextEditingController();
  var temp_ctrl = TextEditingController();
  bool status = false;
  var datalist = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            buildCensorTextField(),
            const SizedBox(height: 20),
            buildTempTextField(),
            const SizedBox(height: 20),
            buildSwitch(),
            const SizedBox(height: 20),
            buildSubmitButton(),
            const SizedBox(height: 20),
            Text('$datalist'),
            buildListView()
          ],
        ),
      ),
    );
  }

  Widget buildCensorTextField() {
    return TextField(
      controller: censor_ctrl,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'กรุณากรอกชื่อ Censor'),
    );
  }

  Widget buildTempTextField() {
    return TextField(
      controller: temp_ctrl,
      decoration: const InputDecoration(
          border: OutlineInputBorder(), hintText: 'กรุณากรอกอุณหภูมิเป็น F'),
      keyboardType: TextInputType.number,
    );
  }

  Widget buildSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('สถานะของ Censor'),
        Switch(
          value: status,
          activeColor: Colors.green,
          onChanged: (value) {
            setState(() {
              status = value;
            });
          },
        ),
      ],
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
        onPressed: () {
          if (censor_ctrl.text.isNotEmpty && temp_ctrl.text.isNotEmpty) {
            var celsius = (double.parse(temp_ctrl.text) - 32) / 9 * 5;
            var statustext = status ? "ON" : "OFF";
            setState(() {
              datalist.add(
                  [censor_ctrl.text, celsius.toStringAsFixed(1), statustext]);
            });
          }
          censor_ctrl.text = '';
          temp_ctrl.text = '';
        },
        child: const Text('Submit'));
  }

  Widget buildListView() {
    return Expanded(
        child: ListView.builder(
      itemCount: datalist.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            leading: Text('Censor Name : ${datalist[index][0]}'),
            title: Text('Temp : ${datalist[index][1]} ํ C'),
            trailing: Text('Status : ${datalist[index][2]}'),
          ),
        );
      },
    ));
  }
}

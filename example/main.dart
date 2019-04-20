import 'package:flutter/material.dart';
import 'package:flutter_sujian_select/flutter_select.dart';



void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Select'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SelectGroup<int>(
              items: <SelectItem<int>>[
                SelectItem(label: '30天', value: 1),
                SelectItem(label: '60天', value: 2),
                SelectItem(label: '90天', value: 3),
              ],
              onSingleSelect: (int value) {
                _scaffoldkey.currentState
                    .showSnackBar(SnackBar(content: Text(value.toString())));
              },
            ),
            SizedBox(
              height: 20,
            ),
            SelectGroup<String>(
              style: SelectStyle.rectangle,
              items: <SelectItem<String>>[
                SelectItem(label: '一', value: '一'),
              ],
              onSingleSelect: (String value) {
                _scaffoldkey.currentState
                    .showSnackBar(SnackBar(content: Text(value.toString())));
              },
            ),
            SizedBox(
              height: 20,
            ),
            SelectGroup<String>(
              style: SelectStyle.rectangle,
              items: <SelectItem<String>>[
                SelectItem(label: '一', value: '一'),
                SelectItem(label: '二', value: '二'),
              ],
              onSingleSelect: (String value) {
                _scaffoldkey.currentState
                    .showSnackBar(SnackBar(content: Text(value.toString())));
              },
            ),
            SizedBox(
              height: 20,
            ),
            SelectGroup<String>(
              style: SelectStyle.rectangle,
              items: <SelectItem<String>>[
                SelectItem(label: '一', value: '一'),
                SelectItem(label: '二', value: '二'),
                SelectItem(label: '三', value: '三'),
                SelectItem(label: '三', value: '三'),
              ],
              onSingleSelect: (String value) {
                _scaffoldkey.currentState
                    .showSnackBar(SnackBar(content: Text(value.toString())));
              },
            ),
            SizedBox(
              height: 20,
            ),
            SelectGroup<int>(
              space: EdgeInsets.all(8.0),
              type: SelectType.multiple,
              listIndex: [2],
              items: <SelectItem<int>>[
                SelectItem(label: '1', value: 1),
                SelectItem(label: '2', value: 2),
                SelectItem(label: '3', value: 3),
                SelectItem(label: '4', value: 4),
              ],
              onMultipleSelect: (List<int> value) {
                _scaffoldkey.currentState
                    .showSnackBar(SnackBar(content: Text(value.toString())));
              },
            ),
            SizedBox(
              height: 20,
            ),
            SelectGroup<int>(
              type: SelectType.multiple,
              style: SelectStyle.rectangle,
              direction: SelectDirection.vertical,
              listIndex: [1, 2],
              items: <SelectItem<int>>[
                SelectItem(label: '1', value: 1),
                SelectItem(label: '2', value: 2),
                SelectItem(label: '3', value: 3),
                SelectItem(label: '4', value: 4),
              ],
              onMultipleSelect: (List<int> value) {
                _scaffoldkey.currentState
                    .showSnackBar(SnackBar(content: Text(value.toString())));
              },
            ),
          ],
        ),
      ),
    );
  }
}

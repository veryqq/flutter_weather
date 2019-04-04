import 'package:flutter/material.dart';

class CitySelection extends StatefulWidget {
  @override
  _CitySelectionState createState() => _CitySelectionState();
}

class _CitySelectionState extends State<CitySelection> {
  final TextEditingController _textEditingController = TextEditingController();
  //不用释放？？
  // @override
  // void dispose() {
  //   _textEditingController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('City'),
      ),
      body: Form(
        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: TextFormField(
                controller: _textEditingController,
                decoration:
                    InputDecoration(labelText: 'City', hintText: 'guangzhou'),
              ),
            ))
     ,IconButton(icon: Icon(Icons.search), onPressed: () {
Navigator.pop(context,_textEditingController.text);

     },
     )
          ],
        ),
      ),
    );
  }
}

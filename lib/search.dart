import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: null,
              hintText: '텍스트를 입력하세요',
              icon: TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                label: Text(''),
              ),
            ),
          ),
          Container(
            height: 300,
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) {
                return ListTile(
                  leading: Text('이미지'),
                  title: Text('무슨무슨 동물병원'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

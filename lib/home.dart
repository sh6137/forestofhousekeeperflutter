import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'search.dart' as search;
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 100),
        Container(
          child: OutlinedButton.icon(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xffF7F7F7)),
              padding: MaterialStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (c) => search.Search(),
                ),
              );
            },
            icon: Icon(Icons.search, size: 25, color: Colors.grey),
            label: Text(
              "동물병원, 동물약국 이름을 검색해보세요",
              style: TextStyle(color: Colors.grey, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: Color(0xffc1c1c1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("이미지 넣을곳"),
                  Text("내 주변 동물병원 찾기"),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              height: 100,
              width: 175,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1, color: Color(0xffc1c1c1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("이미지 넣을곳"),
                  Text("내 주변 동물 약국 찾기"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

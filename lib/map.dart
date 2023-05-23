import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String kakaoMapKey = '92c2a08503f351135012b19f03b32201';

class KakaoMapTest extends StatefulWidget {
  @override
  State<KakaoMapTest> createState() => _KakaoMapTestState();
}

class _KakaoMapTestState extends State<KakaoMapTest> {
  late WebViewController _mapController;
  final double _lat = 33.450701;
  final double _lng = 126.570667;
  int a = 5;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ListView(
            children: [
              KakaoMapView(
                  width: size.width,
                  height: size.height,
                  kakaoMapKey: kakaoMapKey,
                  lat: 33.450701,
                  lng: 126.570667,
                  customScript: '''
    var markers = [];

    function addMarker(position) {

        var marker = new kakao.maps.Marker({position: position});

        marker.setMap(map);

        markers.push(marker);
    }

    for(var i = 0 ; i < $a; i++){
        addMarker(new kakao.maps.LatLng($_lat + 0.0003 * i, $_lng + 0.0003 * i));

        kakao.maps.event.addListener(markers[i], 'click', (function(i) {
          return function(){
            onTapMarker.postMessage('marker ' + i + ' is tapped');
          };
        })(i));
    }

		  var zoomControl = new kakao.maps.ZoomControl();
        map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

        var mapTypeControl = new kakao.maps.MapTypeControl();
        map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
                ''',
                  onTapMarker: (message) {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 300,
                            child: Text("testa"),
                          );
                        });
                  }),
            ],
          ),
          Positioned(
            top: 100,
            left: 20,
            child: Column(
              children: [
                OutlinedButton(
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(350, double.infinity)),
                    backgroundColor: MaterialStateProperty.all(Color(0xffF7F7F7)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    ),
                  ),
                  onPressed: () {},
                  child: Row(
                    children: [
                      Icon(Icons.menu, size: 25, color: Colors.grey),
                      SizedBox(width: 10),
                      Text(
                        "부산시 해운대구",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _testingCustomScript(
      {required Size size, required BuildContext context}) {
    return KakaoMapView(
        width: size.width,
        height: 400,
        kakaoMapKey: kakaoMapKey,
        lat: 33.450701,
        lng: 126.570667,
        customScript: '''
    let markers = [];
    
    function addMarker(position) {
    
      let marker = new kakao.maps.Marker({position: position});

      marker.setMap(map);
    
      markers.push(marker);
    }
    
    for(let i = 0 ; i < 3 ; i++){
      addMarker(new kakao.maps.LatLng(33.450701 + 0.0003 * i, 126.570667 + 0.0003 * i));

      kakao.maps.event.addListener(markers[i], 'click', (i) => {
        return function(){
          onTapMarker.postMessage('marker ' + i + ' is tapped');
        };
      });
    }
    
		  const zoomControl = new kakao.maps.ZoomControl();
      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
   
      const mapTypeControl = new kakao.maps.MapTypeControl();
      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
              ''',
        onTapMarker: (message) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message.message)));
        });
  }
}

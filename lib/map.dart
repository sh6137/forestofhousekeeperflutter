import 'dart:convert';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
          KakaoMapView(
            width: size.width,
            height: size.height,
            kakaoMapKey: kakaoMapKey,
            lat: _lat,
            lng: _lng,
            showMapTypeControl: true,
            showZoomControl: true,
            draggableMarker: true,
            mapType: MapType.BICYCLE,
            mapController: (controller) {
              _mapController = controller;
            },
            // overlayText: '카카오!',
            customOverlayStyle: '''<style>
              .customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
              </style>''',
            customOverlay: '''
const content = '<div class="customoverlay">' +
    '  <a href="https://map.kakao.com/link/map/11394059" target="_blank">' +
    '    <span class="title">카ddd카오!</span>' +
    '  </a>' +
    '</div>';

const position = new kakao.maps.LatLng($_lat, $_lng);

const customOverlay = new kakao.maps.CustomOverlay({
    map: map,
    position: position,
    content: content,
    yAnchor: 1
});
              ''',
            markerImageURL:
                'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png',
            onTapMarker: (message) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message.message)));
            },
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

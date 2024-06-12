import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../business/homeController/HomeController.dart';
import '../../../../conustant/my_colors.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import 'dart:math' as math;

import '../../../../conustant/toast_class.dart';
import '../../../widget/DriverItem.dart';

class QuickOrderScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _QuickOrderScreen();
  }
}

const kGoogleApiKey = 'AIzaSyCCnt7HXFCbMv-KVWNIlpCu8iLGP7RCyCU';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _QuickOrderScreen extends State<QuickOrderScreen>{
  final homeController = Get.put(HomeController());
  late  CameraPosition initialCameraPosition;
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  var isSelected=true;
  int? itemId=1;
  var address;
  final changeLanguageController = Get.put(ChangeLanguageController());
  var lat,lng;
  var selectedFlage=-1;
  BitmapDescriptor? pinLocationIcon;


  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/checked.png');
  }

  @override
  void initState() {
    setCustomMapPin();
    lat=homeController.lat;
    lng=homeController.lng;
    initialCameraPosition = CameraPosition(target:LatLng(lat,  lat), zoom: 12.0);
    //_onMapTapped(LatLng(lat,lng));
    _onMapTapped([
      LatLng(lat, lng),
      LatLng(30.09635754919206, 31.326159797608856),
    ]);
    initialCameraPosition = CameraPosition(
        target: LatLng(homeController.lat, homeController.lng), zoom: 12.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Transform.rotate(
                angle:changeLanguageController.lang=="ar"? 180 *math.pi /180:0,
                child: SvgPicture.asset('assets/back.svg'))
        ),
        title: GestureDetector(
          onTap: (){
            _handlePressButton();
          },
          child: Container(
            height: 8.h,
            padding: EdgeInsetsDirectional.all(2.h),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                color: Colors.white),
            child: Location(),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 1.h),
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: initialCameraPosition,
          markers: markersList,
          //onTap: _onMapTapped,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            googleMapController = controller;
          },
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: 40.h,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 1.h,),
            SvgPicture.asset('assets/home_indicator.svg'),
            DriverList(),
            Container(
              width: double.infinity,
              height: 6.h,
              margin: EdgeInsetsDirectional.all(1.h),
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () async{
                  Navigator.pushNamed(context, '/create_quike_order_screen');
                },
                child: Text('confirm'.tr(),
                  style:  TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_bold',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Location() {
    return Row(
      children: [
        SvgPicture.asset('assets/search.svg',),
        SizedBox(width: 2.w,),
        Text('search_for_your_address'.tr(), style:  TextStyle(fontSize: 12.sp,
            fontFamily: 'lexend_regular',
            fontWeight: FontWeight.w400,
            color: MyColors.Dark3)),
      ],
    );
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: _mode,
        language: 'en',
        strictbounds: false,
        types: [""],
        decoration: InputDecoration(
            hintText: 'Search',
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(color: Colors.white))),
        components: [Component(Component.country, "eg"),]);


    displayPrediction(p!, homeScaffoldKey.currentState);
  }

  void onError(PlacesAutocompleteResponse response) {
    print("ddd" + response.errorMessage!.toString());
    ToastClass.showCustomToast(context, response.errorMessage!, 'error');
  }

  Future<void> displayPrediction(Prediction p, ScaffoldState? currentState) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: kGoogleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );

    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);

    double latitude = detail.result.geometry!.location.lat;
    double longitude = detail.result.geometry!.location.lng;

    markersList.clear();
    markersList.add(
      Marker(
        markerId: const MarkerId("0"),
        position: LatLng(latitude, longitude),
        infoWindow: InfoWindow(title: detail.result.name),
      ),
    );
    googleMapController.animateCamera(
      CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), 14.0),
    );
    //address = await getAddressFromLatLng(latitude.toString(), longitude.toString());
    setState(() {
      lat=latitude.toString();
      lng=longitude.toString();
    });
    //pickUpAddress = address;
    //print("lop1" + address.toString());
  }

  Future<void> _onMapTapped(List<LatLng> positions) async {
    setState(() {
      markersList.clear();
      for (int i = 0; i < positions.length; i++) {
        if(i==0){
          markersList.add(
            Marker(
              markerId: MarkerId(positions[i].toString()),
              position: positions[i],
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
              infoWindow: InfoWindow(
                title: 'My Location $i',
                snippet: 'Lat: ${positions[i].latitude}, Lng: ${positions[i].longitude}',
              ),
            ),
          );
        }else{
          markersList.add(
            Marker(
              markerId: MarkerId(positions[i].toString()),
              position: positions[i],
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
              infoWindow: InfoWindow(
                title: 'Driver $i',
                snippet: 'Lat: ${positions[i].latitude}, Lng: ${positions[i].longitude}',
              ),
            ),
          );
        }

      }
    });
  }

  Widget DriverList(){
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: 5,
          itemBuilder: (context, int index) {
            return DriverItem(
              is_selected: selectedFlage==index,
              onTap: () {
                setState(() {
                  selectedFlage=index;
                });
              },
            );
          }
      ),
    );
  }

}
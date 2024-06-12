
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../../../../business/addressListController/AddressListController.dart';
import '../../../../business/auth/completeUserInfoController/CompleteUserInfoController.dart';
import '../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../business/homeController/HomeController.dart';
import '../../../../conustant/toast_class.dart';
import '../createAccount/create_account_screen.dart';
import 'dart:math' as math;

class LocationScreen extends StatefulWidget{
  var from;
  LocationScreen(this.from);
  @override
  State<StatefulWidget> createState() {
    return _LocationScreen();
  }
}
const kGoogleApiKey = 'AIzaSyCCnt7HXFCbMv-KVWNIlpCu8iLGP7RCyCU';
final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _LocationScreen extends State<LocationScreen> {
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

  final completeUserInfoController = Get.put(CompleteUserInfoController());
  final addressListController = Get.put(AddressListController());
  final changeLanguageController = Get.put(ChangeLanguageController());


  @override
  void initState() {
    completeUserInfoController.lat=homeController.lat;
    completeUserInfoController.lng=homeController.lng;
    initialCameraPosition =
    CameraPosition(
        target:LatLng(completeUserInfoController.lat,  completeUserInfoController.lat), zoom: 14.0);
    _onMapTapped(LatLng(completeUserInfoController.lat,completeUserInfoController.lng));
       initialCameraPosition = CameraPosition(
        target: LatLng(homeController.lat, homeController.lng), zoom: 14.0);

    completeUserInfoController.type="home";
    addressListController.type="home";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: MyColors.BackGroundColor,
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
        title: Center(
          child: Text(
              'delivery_location'.tr(), style: const TextStyle(fontSize: 16,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w400,
              color: MyColors.MainColor)),
        ),
      ),
      body:
      SizedBox(
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                _handlePressButton();
              },
              child: Container(
                height: 8.h,
                margin:  EdgeInsetsDirectional.only(start: 2.5.h, end: 2.5.h),
                padding: EdgeInsetsDirectional.all(2.h),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                    color: MyColors.BackGroundColor),
                child: Location(),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 9.h),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: GoogleMap(
                initialCameraPosition: initialCameraPosition,
                markers: markersList,
                onTap: _onMapTapped,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  googleMapController = controller;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 23.h,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin:  EdgeInsetsDirectional.only(start: 1.h, end: 1.h),
              child: FutureBuilder<String>(
                  future: getAddressFromLatLng(
                      completeUserInfoController.lat??"",
                      completeUserInfoController.lng??""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return  SizedBox(
                          height: 3.h,
                          width: 5.w,
                          child: const CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text(
                          'Error: ${snapshot.error}');
                    } else {
                      pickUpAddress = snapshot.data;
                      return  Text(
                        textAlign: TextAlign.start,
                        pickUpAddress!,maxLines: 2,
                      );
                    }
                  }),
            ),
             SizedBox(height: 1.5.h,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSelected=true;
                      itemId=1;
                      completeUserInfoController.type="home";
                      addressListController.type="home";
                      print("ooooooooooo");
                    });

                  },
                  child: Container(
                    height: 5.5.h,
                    width: 25.w,
                    margin:  EdgeInsetsDirectional.only(start: 1.h, end: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: MyColors.BorderColor, width: 1.0,),
                        color:isSelected==true && itemId==1? MyColors.MainColor:Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/home.svg',color: isSelected==true && itemId==1?Colors.white:MyColors.Dark3),
                         SizedBox(width: 1.5.w,),
                        Text('home2'.tr(), style:  TextStyle(fontSize: 10.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color:isSelected==true && itemId==1?Colors.white:MyColors.Dark3)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSelected=true;
                      itemId=2;
                      completeUserInfoController.type="work";
                      addressListController.type="work";
                      print("ppppppppppppp");
                    });

                  },
                  child: Container(
                    height: 5.5.h,
                    width: 25.w,
                    margin:  EdgeInsetsDirectional.only(start: 1.h, end: 1.h),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: MyColors.BorderColor, width: 1.0,),
                        color: isSelected==true && itemId==2? MyColors.MainColor:Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/building.svg',color: isSelected==true && itemId==2?Colors.white:MyColors.Dark3),
                         SizedBox(width: 1.5.w,),
                        Text('work'.tr(), style:  TextStyle(fontSize: 10.sp,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color:isSelected==true && itemId==2?Colors.white:MyColors.Dark3 )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 2.h,),
            Container(
              width: double.infinity,
              height: 7.h,
              margin:  EdgeInsetsDirectional.only(start: 2.5.h, end: 2.5.h),
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  if(widget.from=="listAddress"){
                    if(completeUserInfoController.lat==""
                    ||completeUserInfoController.lng==""
                    ||completeUserInfoController.address2.value==""
                    ||completeUserInfoController.type==""){
                      ToastClass.showCustomToast(context, "Enter All Data", "error");
                    }else{
                      addressListController.addAddress(context,completeUserInfoController.lat,completeUserInfoController.lng,completeUserInfoController.address2.value);
                    }
                  }else{
                    if(completeUserInfoController.lat==""
                        ||completeUserInfoController.lng==""
                        ||completeUserInfoController.address2.value==""
                        ||completeUserInfoController.type==""){
                      ToastClass.showCustomToast(context, "Enter All Data", "error");
                    }else{
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text('add_location'.tr(),
                  style:  TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_bold',
                      fontWeight: FontWeight.w700,
                      color: Colors.white),),
              ),
            ),
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
        Text(
            'search_for_your_address'.tr(), style:  TextStyle(fontSize: 12.sp,
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
                borderSide: BorderSide(color: Colors.white))),
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
    address = await getAddressFromLatLng(latitude.toString(), longitude.toString());
    setState(() {
        completeUserInfoController.lat=latitude.toString();
        completeUserInfoController.lng=longitude.toString();
    });
    pickUpAddress = address;
    print("lop1" + address.toString());
  }

  void _onMapTapped(LatLng position) async {
    setState(() {
      markersList.clear(); // Clear previous markers
      markersList.add(
        Marker(
          markerId: MarkerId(position.toString()),
          position: position,
          infoWindow: InfoWindow(
            title: 'Marker',
            snippet: 'Lat: ${position.latitude}, Lng: ${position.longitude}',
          ),
        ),
      );
      address= getAddressFromLatLng(position.latitude,position.longitude);
      print("lop2"+address.toString());

        completeUserInfoController.lat = position.latitude.toString();
        completeUserInfoController.lng = position.longitude.toString();
    });
  }

  String? pickUpAddress = 'Loading...';

  Future<String> getAddressFromLatLng(dynamic latitude, longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(latitude), double.parse(longitude));

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];

        completeUserInfoController.address2.value =
            '${placemark.street}, ${placemark.locality}, ${placemark.country}';
          return completeUserInfoController.address2.value;

      } else {
        return "Address not found";
      }
    } catch (e) {
      return "";
    }
  }




}
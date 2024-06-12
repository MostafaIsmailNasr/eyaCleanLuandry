
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';

import '../../../../../business/addressListController/AddressListController.dart';
import '../../../../../business/changeLanguageController/ChangeLanguageController.dart';
import '../../../../../conustant/toast_class.dart';
import 'dart:math' as math;

class EditLocationScreen extends StatefulWidget{
  var latedit;
  var lngedit;
  var addressEdit;
  var id;
  var typeEd;

  EditLocationScreen({required this.latedit,required this.lngedit,required this.addressEdit,required this.id,required this.typeEd});

  @override
  State<StatefulWidget> createState() {
    return _EditLocationScreen();
  }
}
const kGoogleApiKey = 'AIzaSyCCnt7HXFCbMv-KVWNIlpCu8iLGP7RCyCU';
final homeScaffoldKey = GlobalKey<ScaffoldState>();
class _EditLocationScreen extends State<EditLocationScreen> {
  late CameraPosition initialCameraPosition;
  Set<Marker> markersList = {};
  late GoogleMapController googleMapController;
  final Mode _mode = Mode.overlay;
  var lat;
  var lng;
  var address;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  var isSelected=false;
  int? itemId=0;
  final addressListController = Get.put(AddressListController());
  final changeLanguageController = Get.put(ChangeLanguageController());


  @override
  void initState() {
    lat=widget.latedit;
    lng=widget.lngedit;
    initialCameraPosition =
    widget.latedit!=null&& widget.lngedit!=null?
    CameraPosition(
        target:LatLng(double.parse(widget.latedit), double.parse(widget.lngedit)), zoom: 14.0):
    const CameraPosition(
        target:LatLng(30.052417, 31.326583), zoom: 14.0);
    _onMapTapped(LatLng(double.parse(lat),double.parse(lng)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BackGroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.BackGroundColor,
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
      body: Container(
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
                height: 60,
                margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
                padding: EdgeInsetsDirectional.all(12),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    border: Border.all(color: MyColors.MainColor, width: 1.0,),
                    color: MyColors.BackGroundColor),
                child: Location(),
              ),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: 70),
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
        height: 180,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsetsDirectional.only(start: 8, end: 8),
              child: FutureBuilder<String>(
                  future: getAddressFromLatLng(
                      lat??"",
                      lng??""),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator());
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
            const SizedBox(height: 12,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSelected=true;
                      itemId=1;
                      addressListController.type="home";
                      widget.typeEd=addressListController.type;
                      print("ooooooooooo");
                    });

                  },
                  child: Container(
                    height: 40,
                    width: 90,
                    margin: const EdgeInsetsDirectional.only(start: 8, end: 8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: MyColors.MainColor, width: 1.0,),
                        color:((isSelected==true && itemId==1)||widget.typeEd=="home")? MyColors.MainColor:Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/home.svg',color: isSelected==true && itemId==1?Colors.white:MyColors.Dark3),
                        const SizedBox(width: 8,),
                        Text('home2'.tr(), style:  TextStyle(fontSize: 12,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color:((isSelected==true && itemId==1)||widget.typeEd=="home")?Colors.white:MyColors.Dark3)),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      isSelected=true;
                      itemId=2;
                      addressListController.type="work";
                      widget.typeEd=addressListController.type;
                      print("ppppppppppppp");
                    });

                  },
                  child: Container(
                    height: 40,
                    width: 90,
                    margin: const EdgeInsetsDirectional.only(start: 8, end: 8),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: MyColors.MainColor, width: 1.0,),
                        color: ((isSelected==true && itemId==2)||widget.typeEd=="work")? MyColors.MainColor:Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/building.svg',color: isSelected==true && itemId==2?Colors.white:MyColors.Dark3),
                        const SizedBox(width: 8,),
                        Text('work'.tr(), style:  TextStyle(fontSize: 12,
                            fontFamily: 'lexend_regular',
                            fontWeight: FontWeight.w400,
                            color:((isSelected==true && itemId==2)||widget.typeEd=="work")?Colors.white:MyColors.Dark3 )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Container(
              width: double.infinity,
              height: 50,
              margin: const EdgeInsetsDirectional.only(start: 24, end: 24),
              child: TextButton(
                style: flatButtonStyle,
                onPressed: () {
                  addressListController.editAddress(context, lat, lng,widget.addressEdit,widget.id,widget.typeEd);
                },
                child: Text('add_location'.tr(),
                  style: const TextStyle(fontSize: 14,
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
        const SizedBox(width: 5,),
        Text(
            'search_for_your_address'.tr(), style: const TextStyle(fontSize: 14,
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
      lat=latitude.toString();
      lng=longitude.toString();
    });
    pickUpAddress = address;
    print("lop" + address.toString());
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
      print("lop"+address.toString());
      lat = position.latitude.toString();
      lng = position.longitude.toString();
    });
  }

  String? pickUpAddress = 'Loading...';

  Future<String> getAddressFromLatLng(dynamic latitude, longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          double.parse(latitude), double.parse(longitude));

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String address =
            '${placemark.street}, ${placemark.locality}, ${placemark.country}';
        widget.addressEdit=address;
        log("adresss"+address.toString());

        return address;
      } else {
        return "Address not found";
      }
    } catch (e) {
      return "";
    }
  }




}
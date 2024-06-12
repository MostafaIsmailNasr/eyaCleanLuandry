import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';

import '../../../business/offersController/OfferController.dart';
import '../../../conustant/my_colors.dart';
import '../../widget/OfferHomeItem.dart';

class OffersScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _OffersScreen();
  }
}

class _OffersScreen extends State<OffersScreen>{
  final offerController = Get.put(OfferController());

  @override
  void initState() {
    offerController.getOffersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MyColors.BGColor,
        appBar: AppBar(
          backgroundColor: MyColors.BGColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset('assets/back.svg')),
          title: Center(
            child: Text('offers'.tr(),
                style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark1)),
          ),
        ),
        body: OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
            ) {
              final bool connected = connectivity != ConnectivityResult.none;
              if (connected) {
                return Container(
                    margin:
                        EdgeInsetsDirectional.only(start: 24, end: 24, top: 10),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() => !offerController.isLoading.value
                        ? offerList()
                        : const Center(
                            child: CircularProgressIndicator(
                            color: MyColors.MainColor,
                          ))));
              } else {
                return Scaffold(body: NoIntrnet());
              }
            },
            child: const Center(
              child: CircularProgressIndicator(
                color: MyColors.MainColor,
              ),
            )
        )
    );
  }

  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/no_internet.png'),
          SizedBox(height: 1.h,),
          Text('there_are_no_internet'.tr(),
            style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
        ],
      ),

    );
  }

  Widget offerList() {
    if(offerController.offersList.isNotEmpty) {
      return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: offerController.offersList.length,
          itemBuilder: (context, int index) {
            return OfferHomeItem("promotional",
                null, offerController.offersList[index]
            );
          }
      );
    }else{
      return empty();
    }
  }
}

class empty extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 15.h),
      child: Center(
        child: Column(
          children: [
            Image(image: AssetImage('assets/offers_empty.png')),
            //SvgPicture.asset('assets/offers_empty.svg'),
            SizedBox(height: 1.h,),
            Text('there_are_no_offers'.tr(),
              style: TextStyle(fontSize: 14.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10,),
            Text('your_offers_will_appear_here'.tr(),
              style: TextStyle(fontSize: 12.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark2),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

}
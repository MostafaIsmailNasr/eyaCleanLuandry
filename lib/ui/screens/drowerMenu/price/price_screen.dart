import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/priceController/PriceController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../../data/model/priceModel/PriceResponse.dart';
import '../../../widget/priceItem.dart';

class PriceScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _PriceScreen();
  }
}

class _PriceScreen extends State<PriceScreen>{
  final priceController = Get.put(PriceController());
  var con=true;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  @override
  void initState() {
    check();
    priceController.getPriceData();
    super.initState();
  }

  Future<void> check()async{
    final hasInternet = await InternetConnectivity().hasInternetConnection;
    setState(() {
      con = hasInternet;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.BGColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: MyColors.BGColor,
        title: Text(
            'price'.tr(), style:  TextStyle(fontSize: 18.sp,
            fontFamily: 'lexend_bold',
            fontWeight: FontWeight.w800,
            color: MyColors.Dark1)),
      ),
      body: con?
      Obx(() =>!priceController.isLoading.value? DefaultTabController(
          length: priceController.tapsCatList.length,//tabTitles.length,
          child: Column(
            children: [
              Material(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 10.h,
                  color: MyColors.BGColor,
                  child: TabBar(isScrollable: true,
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsetsDirectional.all(10),
                      unselectedLabelColor: MyColors.Dark2,
                      labelStyle: TextStyle(fontSize: 1.8.h,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w400,),
                      labelColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      dividerColor: Colors.transparent,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.MainColor,
                      ),
                      unselectedLabelStyle: TextStyle(fontSize: 1.8.h,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w400,
                          color: Colors.white) ,
                      tabs: [
                        ...priceController.priceResponse.value.data!.asMap().entries.map((entry) {
                          final index = entry.key;
                          return Tab(
                            child: Container(
                              height: 10.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: MyColors.MainColor,
                                  width: 1,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 0.5.h),
                                  child: Text(entry.value.name!),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ]
                  ),
                ),
              ),
              Expanded(
                  child:TabBarView(
                    children: [
                      ...priceController.priceResponse.value.data!.asMap().entries.map((entry) {
                        final index = entry.key;
                        List<SubCategories>? subCategories=priceController.priceResponse.value.data![index].subCategories!;
                        return priceeList(subCategories);
                      }).toList(),

                    ],
                  )
              )
            ],
          ),
        )
            :const Center(child: CircularProgressIndicator(color: MyColors.MainColor,))):NoIntrnet());
      }



  Widget NoIntrnet(){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SvgPicture.asset('assets/no_internet.svg'),
          Image.asset('assets/no_internet.png'),
          SizedBox(height: 10,),
          Text('there_are_no_internet'.tr(),
            style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.bold,color: MyColors.Dark1),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            height: 6.h,
            margin:  EdgeInsetsDirectional.only(start: 1.5.h, end: 1.5.h),
            child: TextButton(
              style: flatButtonStyle,
              onPressed: () async{
                await check();
                priceController.getPriceData();
              },
              child: Text('internet'.tr(),
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: Colors.white),),
            ),
          ),
        ],
      ),

    );
  }

  Widget priceeList(List<SubCategories>? subCategories){
    if(subCategories!.isNotEmpty) {
      return  RefreshIndicator(
        color: Colors.white,
        backgroundColor: MyColors.MainColor,
        strokeWidth: 4.0,
        onRefresh: () async {
          print("lpppppp");
          await check();
          con?
          priceController.getPriceData():NoIntrnet();
        },
        child: Container(
          // height: 350,
          width: MediaQuery
              .of(context)
              .size
              .width,
          margin: EdgeInsetsDirectional.all(2.h),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: subCategories!.length,
              itemBuilder: (context, int index) {
                return PriceItem(
                    subCategories: subCategories![index]
                );
              }
          ),
        ),
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
      margin: const EdgeInsets.only(top: 60),
      child: Center(
        child: Column(
          children: [
            SvgPicture.asset('assets/no_orders.svg'),
            SizedBox(height: 1.h,),
            Text('there_are_no_price'.tr(),
              style: TextStyle(fontSize: 14.sp,
                  fontFamily: 'lexend_bold',
                  fontWeight: FontWeight.w400,
                  color: MyColors.Dark1),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h,),
            Text('your_price_will_appear_here'.tr(),
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
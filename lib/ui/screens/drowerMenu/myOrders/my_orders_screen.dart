import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';
import 'package:sizer/sizer.dart';

import '../../../../business/listOrderController/ListOrderController.dart';
import '../../../../conustant/my_colors.dart';
import '../../../widget/MyOrdersItem.dart';

class MyOrdersScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyOrdersScreen();
  }
}

class _MyOrdersScreen extends State<MyOrdersScreen>{
  final listOrdersController = Get.put(ListOrdersController());
  var con=true;
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  GlobalKey<RefreshIndicatorState>();


  @override
  void initState() {
    check();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      listOrdersController.getListOrders();
    });
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
           'my_orders'.tr(), style:  TextStyle(fontSize: 18.sp,
           fontFamily: 'lexend_bold',
           fontWeight: FontWeight.w800,
           color: MyColors.Dark1)),
     ),
     body: con?
     RefreshIndicator(
         key: _refreshIndicatorKey,
         color: Colors.white,
         backgroundColor: MyColors.MainColor,
         strokeWidth: 4.0,
         onRefresh: () async {
           await check();
           con?
           listOrdersController.getListOrders():NoIntrnet();
         },
       child: Obx(() => !listOrdersController.isLoading.value? priceeList()
           :const Center(child: CircularProgressIndicator(color: MyColors.MainColor,),)),
     ):NoIntrnet(),
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
          SizedBox(height: 1.h,),
          Container(
            width: double.infinity,
            height: 6.h,
            margin:  EdgeInsetsDirectional.only(start: 1.5.h, end: 1.5.h),
            child: TextButton(
              style: flatButtonStyle,
              onPressed: () async{
                await check();
                listOrdersController.getListOrders();
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

  Widget priceeList(){
    if(listOrdersController.orderList.isNotEmpty){
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsetsDirectional.all( 2.h),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: listOrdersController.orderList.length,
            itemBuilder: (context,int index){
              return MyOrdersItem(
                  ordersList: listOrdersController.orderList[index]
              );
            }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset('assets/no_orders.svg'),
              SizedBox(height: 1.h,),
              Text('there_are_no_order'.tr(),
                style: TextStyle(fontSize: 14.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark1),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 1.h,),
              Text('your_order_will_appear_here'.tr(),
                style: TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark2),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
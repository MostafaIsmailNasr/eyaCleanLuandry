import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import 'package:EyaCleanLaundry/conustant/my_colors.dart';
import 'package:EyaCleanLaundry/ui/screens/drowerMenu/price/price_screen.dart';

import '../buttomSheets/orderTypeBottomSheet/choose_order_type.dart';
import '../home/home_screen.dart';
import '../more/more_screen.dart';
import 'myOrders/my_orders_screen.dart';

class DrowerPage extends StatefulWidget{
  int? index;
  DrowerPage({this.index});
  @override
  State<StatefulWidget> createState() {
    return _DrowerPage();
  }
}

class _DrowerPage extends State<DrowerPage>{
  final PageStorageBucket bucket=PageStorageBucket();
  int currenttab = 0;
  Widget? currentScreen;
  @override
  void initState() {
    super.initState();
    setState(() {
      currenttab=widget.index??currenttab;
       currentScreen=currenttab==2?MyOrdersScreen(): HomeScreen();

    });
  }
  final List<Widget> screens=[
    HomeScreen(),
    PriceScreen(),
    MyOrdersScreen(),
    MoreScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageStorage(
        child: currentScreen!,
        bucket: bucket,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: () {
          showModalBottomSheet<void>(
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              context: context,
              backgroundColor: Colors.white,
              builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: ChooseOrderType(null)));
        },
        backgroundColor: MyColors.MainColor2,
        clipBehavior: Clip.antiAlias,
        child:  const Icon(Icons.add,color: Colors.white,),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 10.5.h,
        notchMargin: 8.0,
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   GestureDetector(
                      onTap: (){
                        setState(() {
                          currentScreen=HomeScreen();
                          currenttab=0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/home.svg',width: 4.h,height: 4.h,
                            color: currenttab==0?MyColors.MainColor2:MyColors.Dark3,
                          ),
                          Text('home'.tr(),style: TextStyle(fontSize: 10.sp,
                              fontFamily: 'lexend_bold',
                              fontWeight: FontWeight.w300,
                              color: currenttab==0? MyColors.MainColor2:MyColors.Dark3)),
                        ],
                      ),
                    ),
                const SizedBox(width: 20,),
                   GestureDetector(
                      onTap: (){
                        setState(() {
                          currentScreen=PriceScreen();
                          currenttab=1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/prices.svg',width: 4.h,height: 4.h,
                            color: currenttab==1?MyColors.MainColor2:MyColors.Dark3,
                          ),
                          Text('price'.tr(),style: TextStyle(fontSize: 10.sp,
                              fontFamily: 'lexend_bold',
                              fontWeight: FontWeight.w300,
                              color: currenttab==1? MyColors.MainColor2:MyColors.Dark3)),
                        ],
                      ),
                    ),
                 //),
              ],),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                   GestureDetector(
                      onTap: (){
                        setState(() {
                          currentScreen=MyOrdersScreen();
                          currenttab=2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/orders.svg',width: 4.h,height: 4.h,
                            color: currenttab==2?MyColors.MainColor2:MyColors.Dark3,
                          ),
                          Text('orders'.tr(),style: TextStyle(fontSize: 10.sp,
                              fontFamily: 'lexend_bold',
                              fontWeight: FontWeight.w300,
                              color: currenttab==2? MyColors.MainColor2:MyColors.Dark3)),                          ],
                      ),
                    ),
                 //),
                SizedBox(width: 25,),
                /* Padding(
                   padding:  EdgeInsetsDirectional.only(start: 1.h,end: 2.h),
                   child: */
                   GestureDetector(
                      onTap: (){
                        setState(() {
                          currentScreen=MoreScreen();
                          currenttab=3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/more.svg',width: 4.h,height:4.h,
                            color: currenttab==3?MyColors.MainColor2:MyColors.Dark3,
                          ),
                          Text('more'.tr(), style:  TextStyle(fontSize: 10.sp,
                              fontFamily: 'lexend_bold',
                              fontWeight: FontWeight.w300,
                              color: currenttab==3? MyColors.MainColor2:MyColors.Dark3)),                         ],
                      ),
                    ),
                 //),
              ],
            )
          ],
        )//MyColors.BackGroundColor,
      ),
    );
  }

}
import 'package:flutter/material.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:sizer/sizer.dart';
import '../../conustant/my_colors.dart';
import '../../data/model/homeModel/HomeResponse.dart';
import '../../data/model/offersModel/OffersResponse.dart';
import '../screens/buttomSheets/orderTypeBottomSheet/choose_order_type.dart';

class OfferHomeItem extends StatelessWidget{
  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: MyColors.MainColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ));
  var from;
  final Offers? offers;
  final AllOffers? allOffers;

  OfferHomeItem( this.from, this.offers,this.allOffers);

  @override
  Widget build(BuildContext context) {
    if(from=="home"){
      return InkWell(
        onTap: (){
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
                  child: ChooseOrderType(offers?.id)));
        },
        child: Container(
          width:70.w,
          margin: EdgeInsetsDirectional.only(start: 1.h,end: 1.h,bottom: 1.h),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.white, width: 1.0,),
              color:  Colors.white),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image(image: AssetImage('assets/clothes.png'),width:from=="promotional"?500: 40.h,fit: BoxFit.fill,),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 22.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image:  DecorationImage(image: NetworkImage(offers!.image!),fit: BoxFit.fill),
                      ),
                    ),
                    Positioned(
                        top: 1.5.h,
                        left: 1.5.h,
                        child: offers!.discount!=0?Container(
                          width: 7.h,
                          height: 3.h,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(50)),
                              border: Border.all(color: MyColors.MainColor2, width: 1.0,),
                              color: MyColors.MainColor2),
                          child: Center(
                            child: Text((offers!.discount!.toString()+" %")??"0 %",
                              style:  TextStyle(fontSize: 8.sp,
                                  fontFamily: 'lexend_light',
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white),
                            ),
                          ),
                        ):Container()),
                  ],
                ),
                SizedBox(height: 1.h,),
                Container(
                  padding: EdgeInsets.only(right: 1.h,left: 1.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(offers!.name??"",
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_bold',
                            fontWeight: FontWeight.w700,
                            color: MyColors.Dark1),),
                      offers!.price!=0?Text((offers!.price.toString()??"")+" "+'egp'.tr(),
                        style:  TextStyle(fontSize: 12.sp,
                            fontFamily: 'lexend_bold',
                            fontWeight: FontWeight.w700,
                            color: MyColors.MainColor2),):Container(),
                    ],
                  ),
                ),
                SizedBox(height: 1.5.h,),
                Container(
                    padding: EdgeInsets.only(right: 1.h,left: 1.h),
                    child: Text(offers!.description??"",style:
                    TextStyle(fontSize: 8.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w700,
                        color: MyColors.Dark2))),
                SizedBox(height: 2.2.h,),
                /* Container(
                // width: 40.h,
                padding: EdgeInsets.only(right: 1.h,left: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Promotional_code'.tr(),
                      style:  TextStyle(fontSize: 10.sp,
                          fontFamily: 'lexend_regular',
                          fontWeight: FontWeight.w400,
                          color: MyColors.Dark3),),
                    Text("C8AWL",
                      style:  TextStyle(fontSize: 10.sp,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w500,
                          color: MyColors.Dark1),),
                  ],
                ),
              ),*/
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 6.h,
                  margin: EdgeInsetsDirectional.only(start: 1.h,end: 1.h,top: 1.h),
                  child: TextButton(
                    style: flatButtonStyle,
                    onPressed: () {
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          context: context,
                          backgroundColor: Colors.white,
                          builder: (BuildContext context) => Padding(
                              padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: ChooseOrderType(offers?.id)));
                    },
                    child: Text('get_offer_now'.tr(),
                      style:  TextStyle(fontSize: 10.sp,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w400,
                          color: Colors.white),),
                  ),
                )
              ]),

        ),
      );
    }else {
      return Container(
        width: 70.w,
        margin: EdgeInsetsDirectional.only(start: 1.h, end: 1.h, bottom: 1.5.h),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(color: Colors.white, width: 1.0,),
            color: Colors.white),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 22.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: NetworkImage(allOffers!.image!),
                          fit: BoxFit.fill),
                    ),
                  ),
                  Positioned(
                      top: 1.5.h,
                      left: 1.5.h,
                      child:allOffers!.discount!=0? Container(
                        width: 7.h,
                        height: 3.h,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(50)),
                            border: Border.all(
                              color: MyColors.MainColor2, width: 1.0,),
                            color: MyColors.MainColor2),
                        child: Center(
                          child: Text(
                            (allOffers!.discount!.toString() + " %") ?? "0 %",
                            style: TextStyle(fontSize: 8.sp,
                                fontFamily: 'lexend_light',
                                fontWeight: FontWeight.w300,
                                color: Colors.white),
                          ),
                        ),
                      ):Container()),
                ],
              ),
              SizedBox(height: 1.h,),
              Container(
                padding: EdgeInsets.only(right: 1.h, left: 1.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(allOffers!.name ?? "",
                      style: TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w700,
                          color: MyColors.Dark1),),
                    allOffers!.price!=0?Text((allOffers!.price.toString() ?? "") + " " + 'egp'.tr(),
                      style: TextStyle(fontSize: 12.sp,
                          fontFamily: 'lexend_bold',
                          fontWeight: FontWeight.w700,
                          color: MyColors.MainColor2),):Container(),
                  ],
                ),
              ),
              SizedBox(height: 1.5.h,),
              Container(
                  padding: EdgeInsets.only(right: 1.h, left: 1.h),
                  child: Text(allOffers!.description ?? "", style:
                  TextStyle(fontSize: 8.sp,
                      fontFamily: 'lexend_regular',
                      fontWeight: FontWeight.w700,
                      color: MyColors.Dark2))),
              SizedBox(height: 2.2.h,),
              /* Container(
              // width: 40.h,
              padding: EdgeInsets.only(right: 1.h,left: 1.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Promotional_code'.tr(),
                    style:  TextStyle(fontSize: 10.sp,
                        fontFamily: 'lexend_regular',
                        fontWeight: FontWeight.w400,
                        color: MyColors.Dark3),),
                  Text("C8AWL",
                    style:  TextStyle(fontSize: 10.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w500,
                        color: MyColors.Dark1),),
                ],
              ),
            ),*/
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 6.h,
                margin: EdgeInsetsDirectional.only(
                    start: 1.h, end: 1.h, top: 1.h),
                child: TextButton(
                  style: flatButtonStyle,
                  onPressed: () {
                    showModalBottomSheet<void>(
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)),
                        ),
                        context: context,
                        backgroundColor: Colors.white,
                        builder: (BuildContext context) =>
                            Padding(
                                padding: EdgeInsets.only(
                                    bottom: MediaQuery
                                        .of(context)
                                        .viewInsets
                                        .bottom),
                                child: ChooseOrderType(allOffers?.id)));
                  },
                  child: Text('get_offer_now'.tr(),
                    style: TextStyle(fontSize: 10.sp,
                        fontFamily: 'lexend_bold',
                        fontWeight: FontWeight.w400,
                        color: Colors.white),),
                ),
              )
            ]),

      );
    }
      /*Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(color: Colors.white, width: 1.0,),
          color:  Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: AssetImage('assets/clothes.png')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('work_week'.tr(),
                style: const TextStyle(fontSize: 14,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: MyColors.Dark1),),
              Text("150"+" "+'egp'.tr(),
                style: const TextStyle(fontSize: 14,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w700,
                    color: MyColors.SecondryColor),),
            ],
          ),
          Text("Get ready for a new working week with the workweek offer, cleaning and ironing 3 suits + 6 shirts",
            style: const TextStyle(fontSize: 13,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w300,
                color: MyColors.Dark3),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Promotional_code'.tr(),
                style: const TextStyle(fontSize: 12,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark3),),
              Text("C8AWL",
                style: const TextStyle(fontSize: 14,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w500,
                    color: MyColors.Dark1),),
            ],
          ),
          Container(
            width: double.infinity,
            height: 60,
            child: TextButton(
              style: flatButtonStyle,
              onPressed: () {

              },
              child: Text('get_offer_now'.tr(),
                style: const TextStyle(fontSize: 14,
                    fontFamily: 'lexend_bold',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),),
            ),
          )
        ],
      ),
    );*/
  }

}
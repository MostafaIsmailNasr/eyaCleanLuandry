import 'dart:async';

import 'package:EyaCleanLaundry/conustant/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sizer/sizer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../business/createOrderController/CreateOrderController.dart';
import '../business/dropOffController/DropOffController.dart';
import '../business/pickUpController/PickUpController.dart';
import '../ui/screens/drowerMenu/drower.dart';
import 'package:localize_and_translate/localize_and_translate.dart';






class WebViewPage extends StatefulWidget {
  final link;
  WebViewPage(this.link);
  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  final createOrderController = Get.put(CreateOrderController());
  final pickUpController = Get.put(PickUpController());
  final dropOffController = Get.put(DropOffController());
  bool error = false;
  bool isLoading = true;
  String orderId="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            WebView(
              onPageStarted: (String url) {
                print("Page started loading: $url");
              },
              onPageFinished: (String url) {
                setState(()  {
                  isLoading = false;
                });
              },
              onWebResourceError: (error) {
                this.error = true;
              },
              initialUrl: widget.link,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _controller.complete(controller);
              },
              navigationDelegate: (NavigationRequest request) {
                print("lklk"+request.url.toString());
                setState(()  {
                  isLoading = false;
                  print("Page finished loading: ${request.url.toString()}");
                  Uri uri = Uri.parse(request.url.toString());
                  if(uri.queryParameters['orderId']!=null){
                    orderId = uri.queryParameters['orderId']!;
                    print("iddd"+orderId);
                  }
                });
                createOrderController.noonCallBack(orderId).then((_)async{
                  if(createOrderController.noonRespone.value.resultCode==0
                      &&createOrderController.noonRespone.value.result?.order?.status=="CAPTURED"){
                    createOrderController.isVisable.value=false;
                    await createOrderController.updateStatus2("pending",
                        createOrderController.noonRespone.value.result!.transactions![0].id!).then((_){
                      if(createOrderController.updateStatusResponse.value.success==true){
                        createOrderController.updatePaymentStatus(context, "paid", createOrderController.noonRespone.value.result!.transactions![0].id!);
                        createOrderController.offerId=0;
                        createOrderController.lng="";
                        createOrderController.lat="";
                        createOrderController.streetName.value="";
                        createOrderController.payment.value="";
                        createOrderController.typeOfOrder="";
                        createOrderController.CopunID=null;
                        createOrderController.codeController.clear();
                        createOrderController.promocode.value="";
                        createOrderController.cartItem.clear();
                        createOrderController.discount.value=0.0;
                        createOrderController.totalPrice.value=0;
                        createOrderController.itemPrices=[];
                        createOrderController.quantityList.value=0;
                        createOrderController.itemPrices2.clear();
                        onAlertButtonsPressed(context);
                      }
                    });
                  }else if(createOrderController.noonRespone.value.resultCode==0
                      &&createOrderController.noonRespone.value.result?.order?.status=="CANCELLED"){
                    createOrderController.isVisable.value=false;
                    Navigator.pop(context);
                  }
                  else{
                    await createOrderController.updateStatus2("new", createOrderController.noonRespone.value.result!.order!.id!.toString()).then((_) {
                      if (createOrderController.updateStatusResponse.value.success == true) {
                        createOrderController.isVisable.value=false;
                        onAlertFailerPressed(context,createOrderController.noonRespone.value.result!.order!.errorMesssage!);
                      }
                    });
                    }
                });
                return NavigationDecision.navigate;
              },
            ),
            isLoading
                ? const Center(
                child: CircularProgressIndicator(color: MyColors.MainColor,)
            )
                : Container(),
            error ? Text("تأكد من الاتصال بالانترنت ") : Container(),
          ],
        ),
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
                padding: EdgeInsets.only(top: 20.0),
                child:FloatingActionButton(
                  backgroundColor:Colors.white,
                  onPressed: () {
                    createOrderController.offerId="";
                    createOrderController.lng="";
                    createOrderController.lat="";
                    createOrderController.streetName.value="";
                    createOrderController.payment.value="";
                    createOrderController.typeOfOrder="";
                    createOrderController.CopunID="";
                    createOrderController.addressId=null;
                    createOrderController.codeController.clear();
                    createOrderController.promocode.value="";
                    pickUpController.PickDate="";
                    pickUpController.PickDateHours="";
                    dropOffController.dropDate="";
                    dropOffController.dropDateHours="";
                    createOrderController.totalPrice.value=0;
                    createOrderController.itemPrices=[];
                    createOrderController.quantityList.value=0;
                    createOrderController.cartItem.clear();
                    createOrderController.discount.value=0.0;
                    createOrderController.itemPrices2.clear();
                    Get.back();
                    Get.back();
                    Get.back();
                  },
                  child:  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        size: 25,
                      ),
                    ],
                  ),
                ));
          }
          return Container();
        },
      ),
    );
  }

   onAlertButtonsPressed(BuildContext context) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/checked.svg',width: 7.h,height: 7.h,),
      title: 'congratulations'.tr(),
      style:  AlertStyle(
          titleStyle:TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1),
          descStyle: TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1)
      ),
      desc: 'the_order_was_made_successfully'.tr(),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(50),
          height: 7.h,
          onPressed: ()  {
            Navigator.pushNamedAndRemoveUntil(context,'/drower',ModalRoute.withName('/drower'),arguments: 0);
            // Navigator.pushAndRemoveUntil(context,
            //     MaterialPageRoute(builder: (context) {
            //       return DrowerPage(index: 0,);
            //     }),(route) => false,);
          },
          color: MyColors.MainColor,
          child: Text('home'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),
        ),
        DialogButton(
          height: 7.h,
          radius: BorderRadius.circular(50),
          onPressed: () {
            //Navigator.pushNamedAndRemoveUntil(context,'/drower',ModalRoute.withName('/drower'),arguments: 2);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
                  return DrowerPage(index: 2,);
                }),(route) => false);
          },
          color: MyColors.MainColor2,
          child: Text('my_orders'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),

        )
      ],
    ).show();
  }

  onAlertFailerPressed(BuildContext context,String mess) {
    Alert(
      context: context,
      image: SvgPicture.asset('assets/error_solid.svg',width: 7.h,height: 7.h,),
      title: 'failure'.tr(),
      style:  AlertStyle(
          titleStyle:TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1),
          descStyle: TextStyle(fontSize: 16.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w800,
              color: MyColors.Dark1)
      ),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(50),
          height: 7.h,
          onPressed: ()  {
            Navigator.pushNamedAndRemoveUntil(context,'/drower',ModalRoute.withName('/drower'),arguments: 0);
            // Navigator.pushAndRemoveUntil(context,
            //     MaterialPageRoute(builder: (context) {
            //       return DrowerPage(index: 0,);
            //     }),(route) => false,);
          },
          color: MyColors.SecondryColor,
          child: Text('home'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),
        ),
        DialogButton(
          radius: BorderRadius.circular(50),
          height: 7.h,
          onPressed: ()  {
            Navigator.pop(context);
          },
          color: MyColors.MainColor,
          child: Text('cancel'.tr(), style:  TextStyle(fontSize: 12.sp,
              fontFamily: 'lexend_bold',
              fontWeight: FontWeight.w700,
              color: Colors.white)),
        ),
      ],
      desc: mess,
    ).show();
  }
}
import 'package:dio/dio.dart' as dio1;
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:EyaCleanLaundry/ui/screens/more/termsAndConditions/terms_and_condition.dart';

import '../../conustant/di.dart';
import '../../conustant/my_colors.dart';
import '../../conustant/shared_preference_serv.dart';
import '../model/FaqsModel/FaqsResponse.dart';
import '../model/ListOrderModel/ListOrderResponse.dart';
import '../model/NoonModel/NoonRespone.dart';
import '../model/TermsAndConditionsModel/TermsAndConditionsResponse.dart';
import '../model/UpdateStatusModel/UpdateStatusResponse.dart';
import '../model/aboutAsModel/AboutAsResponse.dart';
import '../model/addressModel/addAddressModel/AddAddressResponse.dart';
import '../model/addressModel/addressListModel/AddressListResponse.dart';
import '../model/addressModel/deleteModel/DeleteResponse.dart';
import '../model/addressModel/editAddressModel/EditAddressResponse.dart';
import '../model/auth/createUserModel/CompleteUserInfoResponse.dart';
import '../model/auth/introModel/IntroResponse.dart';
import '../model/auth/loginModel/LoginResponse.dart';
import '../model/auth/verifyModel/VerifyCodeResponse.dart';
import '../model/auth/verifyModel/resendModel/ResendCodeResponse.dart';
import '../model/copunModel/CopunResponse.dart';
import '../model/createOrderModel/CreateOrderResponse.dart';
import '../model/daySettingModel/DaySettingResponse.dart';
import '../model/dropOffDateModel/DropOffDateResponse.dart';
import '../model/homeModel/HomeResponse.dart';
import '../model/hoursModel/HoursResponse.dart';
import '../model/noonPaymentModel/NoonPaymentResponse.dart';
import '../model/notificationModel/NotificationResponse.dart';
import '../model/offersModel/OffersResponse.dart';
import '../model/pickupDateModel/PickupDateResponse.dart';
import '../model/priceModel/PriceResponse.dart';
import '../model/productCartModel/ProductCartResponse.dart';
import '../model/rateOrderModel/RateOrderResponse.dart';
import '../model/socialModel/SocialResponse.dart';
import '../model/updateTokenModel/UpdateTokenResponse.dart';
import '../model/walletCodeModel/WalletCodeResponse.dart';
import '../model/walletModel/WalletResponse.dart';

class WebService {
  late dio1.Dio dio;
  late dio1.BaseOptions options;
  var baseUrl = "https://dashboard.eyalaundry.com/api";
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  // var language;
  // var userToken;

  WebService() {
    options = dio1.BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(milliseconds: 70 * 1000),
      receiveTimeout: Duration(milliseconds: 70 * 1000),
    );
    dio = dio1.Dio(options);
  }

  void handleError(DioException e) {
    String message = '';

    if (e.error is SocketException) {
      message = 'No internet connection';
    }  else if (e.response != null) {
      if (e.response?.statusCode == 422) {
        dynamic responseData = e.response!.data['message'];

        if (responseData is List) {
          if (responseData.isNotEmpty) {
            message = responseData[0];
          }
        } else
        if (responseData is String) {
          message = responseData;
        } else {
          message = 'An error occurred';
        }
      } else {
        message = '${e.response}';
      }
    } else if (e.type == DioExceptionType.cancel) {
      message = 'Request was canceled';
    } else {
      message = 'An error occurred';
    }
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,backgroundColor: MyColors.STATUSEREDColor
    );
    print("jkjkjkjik"+message);
  }

  Future<IntroResponse> getIntro()async{
    //try {
      var Url="/introduction_screens";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url, //data: params,
          options: dio1.Options(
            headers: {
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return IntroResponse.fromJson(response.data);
    // }catch(e){
    //   print(e.toString());
    //   return IntroResponse();
    // }
  }

  Future<LoginResponse> login(String phone,String code)async{
    try {
      var LoginUrl="/login";
      print(LoginUrl);
      var params={
        'mobile': phone,
        'refer_code': code,
      };
      print(options.baseUrl+LoginUrl+params.toString());
      dio1.Response response = await dio.post(LoginUrl, data: params);
      // options: dio1.Options(
      //   headers: {
      //     "authorization": "Bearer ${token}",
      //   },
      // )
      print(response);
      if(response.statusCode==200){
        print("klkl"+LoginResponse.fromJson(response.data).toString());
        return LoginResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        return LoginResponse();
      }
    }catch(e){
      print(e.toString());
      return LoginResponse();
    }
  }

  Future<VerifyCodeResponse> verifyCode(String code)async{
    try {
      var LoginUrl="/verify_mobile";
      print(LoginUrl);
      var params={
        'code': code,
      };
      print(options.baseUrl+LoginUrl+params.toString());
      dio1.Response response = await dio.post(LoginUrl, data: params,
      options: dio1.Options(
        headers: {
          "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
          "Locale": sharedPreferencesService.getString("lang"),
        },
      ));
      print(response);
      if(response.statusCode==200){
        print("klkl"+VerifyCodeResponse.fromJson(response.data).toString());
        return VerifyCodeResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        return VerifyCodeResponse();
      }
    }catch(e){
      print(e.toString());
      return VerifyCodeResponse();
    }
  }

  Future<ResendCodeResponse> resendCode()async{
    try {
      var LoginUrl="/resend_code";
      print(LoginUrl);
      print(options.baseUrl+LoginUrl);
      dio1.Response response = await dio.post(LoginUrl,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("tokenUser"),
            },
          ));
      print(response);
      if(response.statusCode==200){
        print("klkl"+ResendCodeResponse.fromJson(response.data).toString());
        return ResendCodeResponse.fromJson(response.data);
      }else{
        print("klkl121"+response.statusMessage.toString());
        return ResendCodeResponse();
      }
    }catch(e){
      print(e.toString());
      return ResendCodeResponse();
    }
  }

  Future<CompleteUserInfoResponse> CompleteUserInfo(File? Img,String name,
      String streetName,String type,String lat,String lng,String email)async{
    try {
      var Url="/update_user";
      print(Url);
      if(streetName==""){
        var formData =
        dio1.FormData.fromMap({
          'name': name,
          'email': email,
        });
        if(Img!=null) {
          // //[4] ADD IMAGE TO UPLOAD
          var file = await dio1.MultipartFile.fromFile(Img.path,
              filename: basename(Img.path),
              contentType: MediaType("avatar", "title.png"));
          formData.files.add(MapEntry('avatar', file));
        }
        print(options.baseUrl+Url+formData.toString());
        dio1.Response response = await dio.post(Url,data: formData,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
          print("klkl"+CompleteUserInfoResponse.fromJson(response.data).toString());
          return CompleteUserInfoResponse.fromJson(response.data);
      }else{
        var formData =
        dio1.FormData.fromMap({
          'name': name,
          'email': email,
          'street_name':streetName,
          'type':type,
          'lat':lat,
          'lng':lng,
        });
        if(Img!=null) {
          // //[4] ADD IMAGE TO UPLOAD
          var file = await dio1.MultipartFile.fromFile(Img.path,
              filename: basename(Img.path),
              contentType: MediaType("Img", "title.png"));
          formData.files.add(MapEntry('Img', file));
        }
        print(options.baseUrl+Url+formData.toString());
        dio1.Response response = await dio.post(Url,data: formData,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        if(response.statusCode==200){
          print("klkl"+CompleteUserInfoResponse.fromJson(response.data).toString());
          return CompleteUserInfoResponse.fromJson(response.data);
        }else{
          print("klkl121"+response.statusMessage.toString());
          return CompleteUserInfoResponse();
        }
      }
    }catch(e){
      print(e.toString());
      return CompleteUserInfoResponse();
    }
  }

  Future<HomeResponse> getHomeData(double lat,double lng)async{
    try {
      var Url="/home_page";
      print(Url);
      var params={
        'lat': lat,
        'lng':lng
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
        options: dio1.Options(
          headers: {
            "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
            "Locale": sharedPreferencesService.getString("lang"),
          },
        )
      );
      print(response);
      return HomeResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return HomeResponse();
    }
  }

  Future<PriceResponse> getPriceData(double lat,double lng)async{
    try {
      var Url="/categories/list";
      print(Url);
      var params={
        'lat': lat,
        'lng':lng
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              //"authorization": "Bearer ${userToken}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return PriceResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return PriceResponse();
    }
  }

  Future<OffersResponse> getOffersData(double lat,double lng)async{
    try {
      var Url="/offers/list";
      print(Url);
      var params={
        'lat': lat,
        'lng':lng
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              //"authorization": "Bearer ${userToken}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return OffersResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return OffersResponse();
    }
  }

  Future<NotificationResponse> getNotificationData()async{
    print("tokkk"+sharedPreferencesService.getString("tokenUser"));
    try {
      var Url="/notifications/list";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return NotificationResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return NotificationResponse();
    }
  }

  Future<AddressListResponse> getAddress()async{
    try {
      var Url="/addresses/list";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return AddressListResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return AddressListResponse();
    }
  }

  Future<DeleteResponse> deleteAddress(int id)async{
    try {
      var Url="/addresses/delete/$id";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.delete(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return DeleteResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DeleteResponse();
    }
  }

  Future<AddAddressResponse> addAddress(String address,String lat,String lng,String type)async{
    try {
      var LoginUrl="/addresses/create";
      print(LoginUrl);
      var params={
        'street_name': address,
        'lat': lat,
        'lng': lng,
        'type': type,
      };
      print(options.baseUrl+LoginUrl+params.toString());
      dio1.Response response = await dio.post(LoginUrl,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          ));
      print(response);
        return AddAddressResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return AddAddressResponse();
    }
  }

  Future<EditAddressResponse> editAddress(String address,String lat,String lng,String type,int id)async{
    try {
      var LoginUrl="/addresses/update/$id";
      print(LoginUrl);
      var params={
        'street_name': address,
        'lat': lat,
        'lng': lng,
        'type': type,
      };
      print(options.baseUrl+LoginUrl+params.toString());
      dio1.Response response = await dio.post(LoginUrl,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          ));
      print(response);
      return EditAddressResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return EditAddressResponse();
    }
  }

  Future<CreateOrderResponse> createOrder(
      int addressId,
      int couponId,
      int offerId,
      String type,
      String deliveryDate,
      String receivedDate,
      String payment,
      String notes,
      String productsJson,
      int keyWeeklyLoop,
      int totalPrice,
      double totalAfterDiscount,
      double discount,
      String code)async{
     try {
      var LoginUrl="/order/create";
      print(LoginUrl);
      if(offerId==0&&couponId==0&&code==""){
        var params={
          'address_id': addressId,
          'type': type,
          'delivery_date': deliveryDate,
          'received_date': receivedDate,
          'payment': payment,
          'notes': notes,
          'products': productsJson,
          'key_weekly_loop':keyWeeklyLoop,
          'total': totalPrice,
          'total_after_discount': totalAfterDiscount,
          'discount':discount,
        };
        print(options.baseUrl+LoginUrl+params.toString());
        dio1.Response response = await dio.post(LoginUrl,data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        return CreateOrderResponse.fromJson(response.data);
      }
      else if(offerId!=0&&couponId==0&&code==""){
        var params={
          'address_id': addressId,
          'offer_id': offerId,
          'type': type,
          'delivery_date': deliveryDate,
          'received_date': receivedDate,
          'payment': payment,
          'notes': notes,
          'products':productsJson,
          'key_weekly_loop':keyWeeklyLoop,
          'total': totalPrice,
          'total_after_discount': totalAfterDiscount,
          'discount':discount,
        };
        print(options.baseUrl+LoginUrl+params.toString());
        dio1.Response response = await dio.post(LoginUrl,data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        return CreateOrderResponse.fromJson(response.data);
      }
      else if(offerId!=0&&couponId==0&&code!=""){
        var params={
          'address_id': addressId,
          'offer_id': offerId,
          'type': type,
          'delivery_date': deliveryDate,
          'received_date': receivedDate,
          'payment': payment,
          'notes': notes,
          'products':productsJson,
          'key_weekly_loop':keyWeeklyLoop,
          'total': totalPrice,
          'total_after_discount': totalAfterDiscount,
          'discount':discount,
          'coupon':code
        };
        print(options.baseUrl+LoginUrl+params.toString());
        dio1.Response response = await dio.post(LoginUrl,data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        return CreateOrderResponse.fromJson(response.data);
      }
      else if(offerId==0&&couponId!=0&&code==""){
        var params={
          'address_id': addressId,
          'coupon_id': couponId,
          'type': type,
          'delivery_date': deliveryDate,
          'received_date': receivedDate,
          'payment': payment,
          'notes': notes,
          'products':productsJson,
          'key_weekly_loop':keyWeeklyLoop,
          'total': totalPrice,
          'total_after_discount': totalAfterDiscount,
          'discount':discount,
        };
        print(options.baseUrl+LoginUrl+params.toString());
        dio1.Response response = await dio.post(LoginUrl,data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        return CreateOrderResponse.fromJson(response.data);
      }
      else if(offerId==0&&couponId!=0&&code!=""){
        var params={
          'address_id': addressId,
          'coupon_id': couponId,
          'type': type,
          'delivery_date': deliveryDate,
          'received_date': receivedDate,
          'payment': payment,
          'notes': notes,
          'products':productsJson,
          'key_weekly_loop':keyWeeklyLoop,
          'total': totalPrice,
          'total_after_discount': totalAfterDiscount,
          'discount':discount,
          'coupon':code
        };
        print(options.baseUrl+LoginUrl+params.toString());
        dio1.Response response = await dio.post(LoginUrl,data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        return CreateOrderResponse.fromJson(response.data);
      }
      else {
        var params = {
          'address_id': addressId,
          'coupon_id': couponId,
          'offer_id': offerId,
          'type': type,
          'delivery_date': deliveryDate,
          'received_date': receivedDate,
          'payment': payment,
          'notes': notes,
          'products':productsJson,
          'key_weekly_loop':keyWeeklyLoop,
          'total': totalPrice,
          'total_after_discount': totalAfterDiscount,
          'discount':discount,
          'coupon':code
        };
        print(options.baseUrl + LoginUrl + params.toString());
        dio1.Response response = await dio.post(LoginUrl, data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString(
                    "tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        return CreateOrderResponse.fromJson(response.data);
      }
    }catch(e){
      print(e.toString());
      return CreateOrderResponse();
    }
  }

  Future<PickupDateResponse> getPickupDate()async{
    try {
      var Url="/branchs/pickup_dates";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              //"authorization": "Bearer ${userToken}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return PickupDateResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return PickupDateResponse();
    }
  }

  Future<DropOffDateResponse> getDropOffDate(String orderType,String date)async{
    try {
      var Url="/branchs/dropoff_dates";
      print(Url);
      var params={
        'order_type': orderType,
        'pickup_date':date,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              //"authorization": "Bearer ${userToken}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return DropOffDateResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DropOffDateResponse();
    }
  }

  Future<HoursResponse> getHours(String date,int addressId,String dateType)async{
    try {
      var Url="/branchs/working_hours";
      print(Url);
      var params={
        'date': date,
        'address_id': addressId,
        'date_type': dateType,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              //"authorization": "Bearer ${userToken}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return HoursResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return HoursResponse();
    }
  }

  Future<copunResponse> validateCoupon(String code)async{
    try {
      var Url="/common/validate_coupon";
      print(Url);
      var params={
        'code': code,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString(
                  "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return copunResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return copunResponse();
    }
  }

  Future<WalletResponse> walletBallance()async{
    try {
      var Url="/wallet_transactions";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString(
                  "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return WalletResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return WalletResponse();
    }
  }

  Future<WalletCodeResponse> walletBallanceCode()async{
    try {
      var Url="/wallet_balance";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString(
                  "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return WalletCodeResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return WalletCodeResponse();
    }
  }

  Future<TermsAndConditionsResponse> termsAndCondition()async{
    try {
      var Url="/common/page/terms-and-conditions";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              // "authorization": "Bearer ${sharedPreferencesService.getString(
              //     "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return TermsAndConditionsResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return TermsAndConditionsResponse();
    }
  }

  Future<ListOrderResponse> listOrders()async{
    try {
      var Url="/order/list";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString(
                  "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return ListOrderResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return ListOrderResponse();
    }
  }

  Future<FaqsResponse> faqs(String type)async{
    try {
      var Url="/common/faqs";
      print(Url);
      print(Url);
      var params={
        'type': type,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          options: dio1.Options(
            headers: {
              // "authorization": "Bearer ${sharedPreferencesService.getString(
              //     "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return FaqsResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return FaqsResponse();
    }
  }

  Future<dynamic> updateProfile(File? Img,String name,String email,String mobile)async{
    try {
      var Url="/update_user";
      print(Url);
        var formData =
        dio1.FormData.fromMap({
          'name': name,
          'email': email,
          'mobile':mobile,
        });
        if(Img!=null) {
          // //[4] ADD IMAGE TO UPLOAD
          var file = await dio1.MultipartFile.fromFile(Img.path,
              filename: basename(Img.path),
              contentType: MediaType("avatar", "title.png"));
          formData.files.add(MapEntry('avatar', file));
        }
      print(options.baseUrl+Url+formData.files.toString());
      print(options.baseUrl+Url+formData.fields.toString());
        dio1.Response response = await dio.post(Url,data: formData,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            ));
        print(response);
        if(response.statusCode==200){
          print("klkl"+CompleteUserInfoResponse.fromJson(response.data).toString());
          return CompleteUserInfoResponse.fromJson(response.data);
        }else{
          print("klkl121"+response.statusMessage.toString());
          return CompleteUserInfoResponse();
        }
    }catch(e){
      print(e.toString());
      return CompleteUserInfoResponse();
    }
  }

  Future<AboutAsResponse> aboutUs()async{
    try {
      var Url="/common/page/about-us";
      print(Url);
      print(options.baseUrl+Url);
      dio1.Response response = await dio.get(Url,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString(
                  "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return AboutAsResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return AboutAsResponse();
    }
  }

  Future<SocialResponse> getSocialLinks()async{
    try {
      var Url="/common/settings?";
      print(Url);
      var params={
        'keys[]': ["contact_us","social_media_links"],
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString(
                  "tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return SocialResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return SocialResponse();
    }
  }

  Future<UpdateTokenResponse?> UpdateToken(String token)async{
    var params;
    try {
      var HomeUrl="/update_token";
      if(Platform.isIOS){
        params={
          'ios_token': token,
        };
      }else{
        params={
          'android_token': token,
        };
      }
      print(options.baseUrl+HomeUrl+params.toString());
      dio1.Response response = await dio.post(
          HomeUrl,
          data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print("tokenre"+response.toString());
      return UpdateTokenResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return UpdateTokenResponse();
    }
  }

  Future<DeleteResponse> deleteOrder(int id)async{
    try {
      var Url="/order/cancel";
      print(Url);
      var params={
        'order_id': id,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return DeleteResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DeleteResponse();
    }
  }

  Future<RateOrderResponse> rateOrder(int id,String orderStars,String driverStars,String note)async{
    try {
      var Url="/order/rate";
      if(driverStars=="0.0"){
        print(Url);
        var params={
          'order_id': id,
          'order_stars': orderStars,
          'note': note,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.post(Url,data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            )
        );
        print(response);
        return RateOrderResponse.fromJson(response.data);
      }else{
        print(Url);
        var params={
          'order_id': id,
          'order_stars': orderStars,
          'driver_stars': driverStars,
          'note': note,
        };
        print(options.baseUrl+Url+params.toString());
        dio1.Response response = await dio.post(Url,data: params,
            options: dio1.Options(
              headers: {
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
                "Locale": sharedPreferencesService.getString("lang"),
              },
            )
        );
        print(response);
        return RateOrderResponse.fromJson(response.data);
      }

    }catch(e){
      print(e.toString());
      return RateOrderResponse();
    }
  }

  Future<DaySettingResponse> getOrderDays()async{
    try {
      var Url="/common/settings";
      print(Url);
      var params={
        'keys[]': ["normal_after_days","urgent_after_days"],
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return DaySettingResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return DaySettingResponse();
    }
  }

  Future<ProductCartResponse> getProducts(String lat,String lng)async{
    try {
      var Url="/products/list?";
      print(Url);
      var params={
        'lat':lat,
        'lng':lng,
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.get(Url,queryParameters: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return ProductCartResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return ProductCartResponse();
    }
  }

  Future<NoonPaymentResponse> noonPayment(double amount)async{
    try {
      var userId=sharedPreferencesService.getInt("id");
      var orderId=sharedPreferencesService.getInt("orderId");
      var userName=sharedPreferencesService.getString("phone_number");
      var Url="/order/api/payment/initiate/mobile";
        //print(Url);
        var params={
          'amount':amount,
          'currency': "SAR",
          'channel': "",
          'category':"",
          'reference': "EyaCleanLaundry-$userId-$orderId",
          'name': userName
        };
        print(baseUrl.toString()+Url+params.toString());
        dio1.Response response = await dio.post(Url,data: params,
            options: dio1.Options(
              headers: {
                "Accept": "application/json",
                "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              },
            )
        );
        print(response);
        return NoonPaymentResponse.fromJson(response.data);

    }on DioException  catch(e){
      print(e.toString());
      handleError(e);
      return NoonPaymentResponse();
    }
  }

  Future<UpdateStatusResponse> updateOrderStatus(int id,String status,String transaction_id)async{
    try {
      var Url="/orders/updateOrderStatus";
      print(Url);
      var params={
        'order_id':id,
        'status':status,
        'transaction_id':transaction_id
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return UpdateStatusResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return UpdateStatusResponse();
    }
  }

  Future<UpdateStatusResponse> updatePaymentStatus(int id,String status,String transactionId)async{
    try {
      var Url="/order/updatePaymentStatus";
      print(Url);
      var params={
        'order_id':id,
        'status':status,
        'transaction_id':transactionId
      };
      print(options.baseUrl+Url+params.toString());
      dio1.Response response = await dio.post(Url,data: params,
          options: dio1.Options(
            headers: {
              "authorization": "Bearer ${sharedPreferencesService.getString("tokenUser")}",
              "Locale": sharedPreferencesService.getString("lang"),
            },
          )
      );
      print(response);
      return UpdateStatusResponse.fromJson(response.data);
    }catch(e){
      print(e.toString());
      return UpdateStatusResponse();
    }
  }

  Future<NoonRespone> noonCallBack(String orderId)async{
    try {
      var Url="/order/noonRespone/$orderId";
      print(Url);
      print(baseUrl.toString()+Url);
      dio1.Response response = await dio.get(Url,
        options: dio1.Options(
          headers: {
            //"Content-Type":"application/json",
            "Accept": "application/json",
          },
        )
      );
      print(response);
      return NoonRespone.fromJson(response.data);

    }on DioException catch(e){
      print(e.toString());
      handleError(e);
      return NoonRespone();
    }
  }
}
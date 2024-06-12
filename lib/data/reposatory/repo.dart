import 'dart:ffi';
import 'dart:io';

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
import '../web_service/WebServices.dart';

class Repo {
  WebService webService;
  Repo(this.webService);

  Future<IntroResponse> getIntro()async{
    final intro=await webService.getIntro();
    return intro;
  }

  Future<LoginResponse> login(String phone,String code)async{
    final login=await webService.login(phone,code);
    return login;
  }
  Future<VerifyCodeResponse> verifyCode(String code)async{
    final verify=await webService.verifyCode(code);
    return verify;
  }

  Future<ResendCodeResponse> resendCode()async{
    final resend=await webService.resendCode();
    return resend;
  }

  Future<CompleteUserInfoResponse> CompleteUserInfo(File? Img,String name,
      String streetName,String type,String lat,String lng,String email)async{
    final completeUserInfo=await webService.CompleteUserInfo(Img, name, streetName, type, lat, lng, email);
    return completeUserInfo;
  }

  Future<HomeResponse> getHomeData(double lat,double lng)async{
    final home=await webService.getHomeData(lat, lng);
    return home;
  }

  Future<PriceResponse> getPriceData(double lat,double lng)async{
    final price=await webService.getPriceData(lat, lng);
    return price;
  }

  Future<OffersResponse> getOffersData(double lat,double lng)async{
    final offers=await webService.getOffersData(lat, lng);
    return offers;
  }

  Future<NotificationResponse> getNotificationData()async{
    final notification=await webService.getNotificationData();
    return notification;
  }

  Future<AddressListResponse> getAddress()async{
    final address=await webService.getAddress();
    return address;
  }

  Future<DeleteResponse> deleteAddress(int id)async{
    final delete=await webService.deleteAddress(id);
    return delete;
  }

  Future<AddAddressResponse> addAddress(String address,String lat,String lng,String type)async{
    final Addaddress=await webService.addAddress(address, lat, lng, type);
    return Addaddress;
  }

  Future<EditAddressResponse> editAddress(String address,String lat,String lng,String type,int id)async{
    final Editaddress=await webService.editAddress(address, lat, lng, type,id);
    return Editaddress;
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
    final createOrder=await webService.createOrder(
        addressId,
        couponId,
        offerId,
        type,
        deliveryDate,
        receivedDate,
        payment,
        notes,
        productsJson,
        keyWeeklyLoop,
        totalPrice,
        totalAfterDiscount,
        discount,
        code);
    return createOrder;
  }

  Future<PickupDateResponse> getPickupDate()async{
    final pickupDate=await webService.getPickupDate();
    return pickupDate;
  }

  Future<DropOffDateResponse> getDropOffDate(String orderType,String date)async{
    final dropOffDate=await webService.getDropOffDate(orderType,date);
    return dropOffDate;
  }

  Future<HoursResponse> getHours(String date,int addressId,String dateType)async{
    final hours=await webService.getHours(date,addressId,dateType);
    return hours;
  }

  Future<copunResponse> validateCoupon(String code)async{
    final coupon=await webService.validateCoupon(code);
    return coupon;
  }

  Future<WalletResponse> walletBallance()async{
    final wallet=await webService.walletBallance();
    return wallet;
  }

  Future<WalletCodeResponse> walletBallanceCode()async{
    final walletcode=await webService.walletBallanceCode();
    return walletcode;
  }

  Future<TermsAndConditionsResponse> termsAndCondition()async{
    final terms=await webService.termsAndCondition();
    return terms;
  }

  Future<ListOrderResponse> listOrders()async{
    final listorders=await webService.listOrders();
    return listorders;
  }

  Future<FaqsResponse> faqs(String type)async{
    final faqs=await webService.faqs(type);
    return faqs;
  }

  Future<CompleteUserInfoResponse> updateProfile(File? Img,String name,String email,String mobile)async{
    final update=await webService.updateProfile(Img, name, email, mobile);
    return update;
  }

  Future<AboutAsResponse> aboutUs()async{
    final about=await webService.aboutUs();
    return about;
  }

  Future<SocialResponse> getSocialLinks()async{
    final social=await webService.getSocialLinks();
    return social;
  }

  Future<UpdateTokenResponse?> UpdateToken(String token)async{
    final tokenFir=await webService.UpdateToken(token);
    return tokenFir;
  }

  Future<DeleteResponse> deleteOrder(int id)async{
    final deletOrder=await webService.deleteOrder(id);
    return deletOrder;
  }

  Future<RateOrderResponse> rateOrder(int id,String orderStars,String driverStars,String note)async{
    final rate=await webService.rateOrder(id,orderStars,driverStars,note);
    return rate;
  }

  Future<DaySettingResponse> getOrderDays()async{
    final day=await webService.getOrderDays();
    return day;
  }

  Future<ProductCartResponse> getProducts(String lat,String lng)async{
    final product=await webService.getProducts(lat, lng);
    return product;
  }

  Future<NoonPaymentResponse> noonPayment(double amount)async{
    final noon=await webService.noonPayment(amount);
    return noon;
  }

  Future<NoonRespone> noonCallBack(String orderId)async{
    final nooncall=await webService.noonCallBack(orderId);
    return nooncall;
  }

  Future<UpdateStatusResponse> updateOrderStatus(int id,String status,String transaction_id)async{
    final updateStatus=await webService.updateOrderStatus(id,status,transaction_id);
    return updateStatus;
  }

  Future<UpdateStatusResponse> updatePaymentStatus(int id,String status,String transactionId)async{
    final updatePaymentStatus=await webService.updatePaymentStatus(id,status,transactionId);
    return updatePaymentStatus;
  }

}
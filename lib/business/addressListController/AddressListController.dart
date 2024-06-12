
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../conustant/di.dart';
import '../../conustant/shared_preference_serv.dart';
import '../../conustant/toast_class.dart';
import '../../data/model/addressModel/addAddressModel/AddAddressResponse.dart';
import '../../data/model/addressModel/addressListModel/AddressListResponse.dart';
import '../../data/model/addressModel/deleteModel/DeleteResponse.dart';
import '../../data/model/addressModel/editAddressModel/EditAddressResponse.dart';
import '../../data/reposatory/repo.dart';
import '../../data/web_service/WebServices.dart';
import '../auth/completeUserInfoController/CompleteUserInfoController.dart';

class AddressListController extends GetxController {
  Repo repo = Repo(WebService());
  var addressListResponse = AddressListResponse().obs;
  var deleteResponse = DeleteResponse().obs;
  var addAddressResponse = AddAddressResponse().obs;
  var editAddressResponse = EditAddressResponse().obs;
  var isLoading = false.obs;
  Rx<bool> isVisable = false.obs;
  RxList<dynamic> addressList=[].obs;
  final SharedPreferencesService sharedPreferencesService =
  instance<SharedPreferencesService>();
  var userName;
  var type;
  var typeEdit;
  final completeUserInfoController = Get.put(CompleteUserInfoController());

  getAddressList()async{
    isLoading.value=true;
    userName=sharedPreferencesService.getString("fullName");
    addressListResponse.value = await repo.getAddress();
    if(addressListResponse.value.success==true){
      isLoading.value=false;
      addressList.value=addressListResponse.value.data as List;
    }
    return addressListResponse.value;
  }

  deleteAddress(int id,BuildContext context)async{
    isLoading.value=true;
    deleteResponse.value=await repo.deleteAddress(id);
    if(deleteResponse.value.success==true){
      isLoading.value=false;
      Get.back();
      getAddressList();
      return deleteResponse.value;
    }else {
      isLoading.value=false;
      Get.back();
      ToastClass.showCustomToast(context, deleteResponse.value.message, 'error');

    }
  }

  addAddress(BuildContext context,String lat,String lng,String address) async {
    addAddressResponse.value = await repo.addAddress(address,lat,lng,type);
    if (addAddressResponse.value.success == true) {
      isVisable.value = false;
      completeUserInfoController.lng="";
      completeUserInfoController.lat="";
      completeUserInfoController.address2.value="";
      completeUserInfoController.type="";
      Navigator.pop(context);
      getAddressList();
    } else {
      isVisable.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(addAddressResponse.value.message!),
        ),
      );
    }
  }

  editAddress(BuildContext context,String lat,String lng,String address,int id,String typeEd) async {
    editAddressResponse.value = await repo.editAddress(address,lat,lng,typeEd,id);
    if (editAddressResponse.value.success == true) {
      isVisable.value = false;
      Navigator.pop(context);
      getAddressList();
    } else {
      isVisable.value = false;
      ScaffoldMessenger.of(context!).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(editAddressResponse.value.message!),
        ),
      );
    }
  }
}
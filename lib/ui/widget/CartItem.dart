import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';

import '../../business/createOrderController/CreateOrderController.dart';
import '../../conustant/my_colors.dart';
import '../../data/model/productCartModel/ProductCartResponse.dart';

class CartItem extends StatefulWidget{
  Products products;
  CartItem({required this.products});

  @override
  State<StatefulWidget> createState() {
    return _CartItem();
  }
}

class _CartItem extends State<CartItem>{
  var quntity=0;
  var price=150;
  var total=0;
  Rx<int> ItemPrice=0.obs;
  var updatedQuantity=0.obs;
  final createOrderController = Get.put(CreateOrderController());


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(bottom: 1.5.h),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(widget.products.image!,height: 5.h),
          SizedBox(width: 1.h,),
          Column(
            children: [
              SizedBox(
                width: 12.h,
                child: Text(
                  widget.products.name??"",
                  style:  TextStyle(fontSize: 12.sp,
                      fontFamily: 'lexend_regular',
                      fontWeight: FontWeight.w400,
                      color: MyColors.Dark1),
                ),
              ),
              Text(
                createOrderController.typeOfOrder=="normal"?
                "${widget.products.regularPrice??"0.0"}SAR":"${widget.products.urgentPrice??"0.0"}SAR",
                style:  TextStyle(fontSize: 12.sp,
                    fontFamily: 'lexend_regular',
                    fontWeight: FontWeight.w400,
                    color: MyColors.Dark1),
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: (){
              calculateMinus();
            },
              child: SvgPicture.asset('assets/mine.svg')),
          SizedBox(width: 1.h,),
          Text(createOrderController.getItemPrice(widget.products.id!).toString(),
            style:  TextStyle(fontSize: 12.sp,
                fontFamily: 'lexend_regular',
                fontWeight: FontWeight.w400,
                color: MyColors.Dark1),
          ),
          SizedBox(width: 1.h,),
          InkWell(
            onTap: (){
              calculatePlus();
            },
              child: SvgPicture.asset('assets/plus.svg')),
        ],
      ),
    );
  }

  void calculateMinus() {
    setState(() {
      createOrderController.discount.value=0.0;
      createOrderController.promocode.value="";
      createOrderController.CopunID=null;
      int existingIndex = createOrderController.cartItem.indexWhere((item) => item.id == widget.products.id);

      if (existingIndex != -1) {
        // Product ID exists in the list, increment its quantity
        var existingProduct = createOrderController.cartItem[existingIndex];
        if (existingProduct.quantity! >1) {
          var updatedQuantity = existingProduct.quantity! - 1; // Increment quantity if not null
          if (createOrderController.itemPrices2.containsKey(widget.products.id!)) {
            if (createOrderController.itemPrices2[widget.products.id]! > 0) {
              createOrderController.itemPrices2[widget.products.id!] = createOrderController.itemPrices2[widget.products.id]! - 1;
            }
          }

          createOrderController.cartItem[existingIndex] = Products(
            id: existingProduct.id,
            regularPrice: existingProduct.regularPrice,
            urgentPrice: existingProduct.urgentPrice,
            quantity: updatedQuantity,
          );
          createOrderController.quantityList.value--;
          if (createOrderController.itemPrices.isNotEmpty) {
            createOrderController.itemPrices.removeLast(); // Remove the last added price from the list
          }
          calculateTotalPrice();
        }
        else {
          if (createOrderController.itemPrices2.containsKey(widget.products.id!)) {
            if (createOrderController.itemPrices2[widget.products.id]! > 0) {
              createOrderController.itemPrices2[widget.products.id!] = createOrderController.itemPrices2[widget.products.id]! - 1;
            }
          }
          createOrderController.quantityList.value--;
          if (createOrderController.itemPrices.isNotEmpty) {
            createOrderController.itemPrices.removeLast(); // Remove the last added price from the list
          }
          createOrderController.cartItem.removeWhere((element) => element.id==widget.products.id);
          calculateTotalPrice();
      }
      }

      // Update the JSON representation of the products
      createOrderController.productsJson.value = createOrderController.convertProductListToJson(createOrderController.cartItem);
      print("Updated JSON1: " + createOrderController.productsJson.value);
    });
  }

  void calculatePlus() {
    setState(() {
      int existingIndex = createOrderController.cartItem.indexWhere((item) => item.id == widget.products.id);
      createOrderController.typeOfOrder=="normal"?
      createOrderController.itemPrices.add((widget.products.regularPrice??0))
          :createOrderController.itemPrices.add((widget.products.urgentPrice??0));
      createOrderController.quantityList.value++;
      createOrderController.discount.value=0.0;
      createOrderController.promocode.value="";
      createOrderController.CopunID=null;

      if (existingIndex != -1) {
        // Product ID exists in the list, increment its quantity
        var existingProduct = createOrderController.cartItem[existingIndex];
        if (existingProduct.quantity != null) {
          var updatedQuantity = existingProduct.quantity! + 1; // Increment quantity if not null
          if (createOrderController.itemPrices2.containsKey(widget.products.id)) {
            createOrderController.itemPrices2[widget.products.id!] = (createOrderController.itemPrices2[widget.products.id] ?? 0) + 1;
          } else {
            createOrderController.itemPrices2[widget.products.id!] = 1;
          }
          createOrderController.cartItem[existingIndex] = Products(
            id: existingProduct.id,
            regularPrice: existingProduct.regularPrice,
            urgentPrice: existingProduct.urgentPrice,
            quantity: updatedQuantity,
          );
        }
      } else {
        if (createOrderController.itemPrices2.containsKey(widget.products.id)) {
          createOrderController.itemPrices2[widget.products.id!] = (createOrderController.itemPrices2[widget.products.id] ?? 0) + 1;
        } else {
          createOrderController.itemPrices2[widget.products.id!] = 1;
        }
        createOrderController.cartItem.add(
          Products(
            id: widget.products.id,
            regularPrice: widget.products.regularPrice,
            urgentPrice: widget.products.urgentPrice,
            quantity:1 //createOrderController.quntity2.value,
          ),
        );
      }
      calculateTotalPrice();

      // Update the JSON representation of the products
      createOrderController.productsJson.value = createOrderController.convertProductListToJson(createOrderController.cartItem);
      print("Updated JSON1: " + createOrderController.productsJson.value);
    });
  }




  int calculateTotalPrice() {
    int totalPrice = 0;
    setState(() {
      for (var product in createOrderController.cartItem) {
        if(createOrderController.type=="normal"){
          totalPrice += (product.regularPrice ?? 0) * (product.quantity ?? 0);
        }else{
          totalPrice += (product.urgentPrice ?? 0) * (product.quantity ?? 0);
        }

      }
      print("jkhjhj"+totalPrice.toString());
      createOrderController.totalPrice.value=totalPrice;
      createOrderController.totalAfterDiscount.value=createOrderController.totalPrice.value.toDouble();
    });
    return totalPrice;
  }

}
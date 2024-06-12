import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tabby_flutter_inapp_sdk/tabby_flutter_inapp_sdk.dart';

import '../../../../../business/createOrderController/CreateOrderController.dart';

final createOrderController = Get.put(CreateOrderController());
 final mockPayload = Payment(
  amount: createOrderController.totalAfterDiscount.value.toString(),
  currency: Currency.sar,
  buyer: Buyer(
    email: '',
    phone: '',
    name: '',
    dob: '2019-08-24',
  ),
  buyerHistory: BuyerHistory(
    loyaltyLevel: 0,
    registeredSince: '2019-08-24T14:15:22Z',
    wishlistCount: 0,
  ),
  shippingAddress: const ShippingAddress(
    city: 'string',
    address: 'string',
    zip: 'string',
  ),
  order: Order(referenceId: 'id123', items: [
    OrderItem(
      title: 'Jersey',
      description: 'Jersey',
      quantity: 1,
      unitPrice: '10.00',
      referenceId: 'uuid',
      productUrl: 'http://example.com',
      category: 'clothes',
    )
  ]),
  orderHistory: [
    OrderHistoryItem(
      purchasedAt: '2019-08-24T14:15:22Z',
      amount: '10.00',
      paymentMethod: OrderHistoryItemPaymentMethod.card,
      status: OrderHistoryItemStatus.newOne,
    )
  ],
);
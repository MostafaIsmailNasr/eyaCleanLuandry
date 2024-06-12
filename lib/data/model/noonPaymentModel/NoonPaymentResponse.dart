class NoonPaymentResponse {
  int? resultCode;
  String? message;
  int? resultClass;
  String? classDescription;
  String? actionHint;
  String? requestReference;
  Result? result;

  NoonPaymentResponse(
      {this.resultCode,
        this.message,
        this.resultClass,
        this.classDescription,
        this.actionHint,
        this.requestReference,
        this.result});

  NoonPaymentResponse.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    message = json['message'];
    resultClass = json['resultClass'];
    classDescription = json['classDescription'];
    actionHint = json['actionHint'];
    requestReference = json['requestReference'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['resultCode'] = this.resultCode;
    data['message'] = this.message;
    data['resultClass'] = this.resultClass;
    data['classDescription'] = this.classDescription;
    data['actionHint'] = this.actionHint;
    data['requestReference'] = this.requestReference;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? nextActions;
  Order? order;
  Configuration? configuration;
  Business? business;
  CheckoutData? checkoutData;
  DeviceFingerPrint? deviceFingerPrint;
  List<PaymentOptions>? paymentOptions;

  Result(
      {this.nextActions,
        this.order,
        this.configuration,
        this.business,
        this.checkoutData,
        this.deviceFingerPrint,
        this.paymentOptions});

  Result.fromJson(Map<String, dynamic> json) {
    nextActions = json['nextActions'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    configuration = json['configuration'] != null
        ? new Configuration.fromJson(json['configuration'])
        : null;
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    checkoutData = json['checkoutData'] != null
        ? new CheckoutData.fromJson(json['checkoutData'])
        : null;
    deviceFingerPrint = json['deviceFingerPrint'] != null
        ? new DeviceFingerPrint.fromJson(json['deviceFingerPrint'])
        : null;
    if (json['paymentOptions'] != null) {
      paymentOptions = <PaymentOptions>[];
      json['paymentOptions'].forEach((v) {
        paymentOptions!.add(new PaymentOptions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextActions'] = this.nextActions;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.configuration != null) {
      data['configuration'] = this.configuration!.toJson();
    }
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    if (this.checkoutData != null) {
      data['checkoutData'] = this.checkoutData!.toJson();
    }
    if (this.deviceFingerPrint != null) {
      data['deviceFingerPrint'] = this.deviceFingerPrint!.toJson();
    }
    if (this.paymentOptions != null) {
      data['paymentOptions'] =
          this.paymentOptions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  String? status;
  String? creationTime;
  int? errorCode;
  dynamic? id;
  int? amount;
  String? currency;
  String? name;
  String? reference;
  String? category;
  String? channel;

  Order(
      {this.status,
        this.creationTime,
        this.errorCode,
        this.id,
        this.amount,
        this.currency,
        this.name,
        this.reference,
        this.category,
        this.channel});

  Order.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    creationTime = json['creationTime'];
    errorCode = json['errorCode'];
    id = json['id'];
    amount = json['amount'];
    currency = json['currency'];
    name = json['name'];
    reference = json['reference'];
    category = json['category'];
    channel = json['channel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['creationTime'] = this.creationTime;
    data['errorCode'] = this.errorCode;
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['name'] = this.name;
    data['reference'] = this.reference;
    data['category'] = this.category;
    data['channel'] = this.channel;
    return data;
  }
}

class Configuration {
  bool? tokenizeCc;
  String? returnUrl;
  String? locale;
  String? paymentAction;

  Configuration(
      {this.tokenizeCc, this.returnUrl, this.locale, this.paymentAction});

  Configuration.fromJson(Map<String, dynamic> json) {
    tokenizeCc = json['tokenizeCc'];
    returnUrl = json['returnUrl'];
    locale = json['locale'];
    paymentAction = json['paymentAction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tokenizeCc'] = this.tokenizeCc;
    data['returnUrl'] = this.returnUrl;
    data['locale'] = this.locale;
    data['paymentAction'] = this.paymentAction;
    return data;
  }
}

class Business {
  dynamic? id;
  String? name;

  Business({this.id, this.name});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class CheckoutData {
  String? postUrl;
  String? jsUrl;

  CheckoutData({this.postUrl, this.jsUrl});

  CheckoutData.fromJson(Map<String, dynamic> json) {
    postUrl = json['postUrl'];
    jsUrl = json['jsUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['postUrl'] = this.postUrl;
    data['jsUrl'] = this.jsUrl;
    return data;
  }
}

class DeviceFingerPrint {
  String? sessionId;

  DeviceFingerPrint({this.sessionId});

  DeviceFingerPrint.fromJson(Map<String, dynamic> json) {
    sessionId = json['sessionId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sessionId'] = this.sessionId;
    return data;
  }
}

class PaymentOptions {
  String? method;
  String? type;
  String? action;
  Data? data;

  PaymentOptions({this.method, this.type, this.action, this.data});

  PaymentOptions.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    type = json['type'];
    action = json['action'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['type'] = this.type;
    data['action'] = this.action;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  //List<String>? supportedCardBrands;
  EncryptionSettings? encryptionSettings;
  String? cvvRequired;
  String? merchantIdentifier;
  PaymentRequest? paymentRequest;

  Data(
      {//this.supportedCardBrands,
        this.encryptionSettings,
        this.cvvRequired,
        this.merchantIdentifier,
        this.paymentRequest});

  Data.fromJson(Map<String, dynamic> json) {
    //supportedCardBrands = json['supportedCardBrands'].cast<String>();
    encryptionSettings = json['encryptionSettings'] != null
        ? new EncryptionSettings.fromJson(json['encryptionSettings'])
        : null;
    cvvRequired = json['cvvRequired'];
    merchantIdentifier = json['merchantIdentifier'];
    paymentRequest = json['paymentRequest'] != null
        ? new PaymentRequest.fromJson(json['paymentRequest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //data['supportedCardBrands'] = this.supportedCardBrands;
    if (this.encryptionSettings != null) {
      data['encryptionSettings'] = this.encryptionSettings!.toJson();
    }
    data['cvvRequired'] = this.cvvRequired;
    data['merchantIdentifier'] = this.merchantIdentifier;
    if (this.paymentRequest != null) {
      data['paymentRequest'] = this.paymentRequest!.toJson();
    }
    return data;
  }
}

class EncryptionSettings {
  Key? key;

  EncryptionSettings({this.key});

  EncryptionSettings.fromJson(Map<String, dynamic> json) {
    key = json['key'] != null ? new Key.fromJson(json['key']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.key != null) {
      data['key'] = this.key!.toJson();
    }
    return data;
  }
}

class Key {
  String? type;
  String? pemFormatedKey;

  Key({this.type, this.pemFormatedKey});

  Key.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    pemFormatedKey = json['pemFormatedKey'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['pemFormatedKey'] = this.pemFormatedKey;
    return data;
  }
}

class PaymentRequest {
  String? countryCode;
  String? currencyCode;
  Total? total;
 // List<String>? supportedNetworks;
  //List<String>? merchantCapabilities;

  PaymentRequest(
      {this.countryCode,
        this.currencyCode,
        this.total,
        //this.supportedNetworks,
        //this.merchantCapabilities
      });

  PaymentRequest.fromJson(Map<String, dynamic> json) {
    countryCode = json['countryCode'];
    currencyCode = json['currencyCode'];
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    //supportedNetworks = json['supportedNetworks'].cast<String>()??[];
    //merchantCapabilities = json['merchantCapabilities'].cast<String>()??[];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryCode'] = this.countryCode;
    data['currencyCode'] = this.currencyCode;
    if (this.total != null) {
      data['total'] = this.total!.toJson();
    }
    //data['supportedNetworks'] = this.supportedNetworks;
    //data['merchantCapabilities'] = this.merchantCapabilities;
    return data;
  }
}

class Total {
  String? label;
  int? amount;

  Total({this.label, this.amount});

  Total.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['amount'] = this.amount;
    return data;
  }
}
class NoonRespone {
  int? resultCode;
  String? message;
  int? resultClass;
  String? classDescription;
  String? actionHint;
  String? requestReference;
  Result? result;

  NoonRespone(
      {this.resultCode,
        this.message,
        this.resultClass,
        this.classDescription,
        this.actionHint,
        this.requestReference,
        this.result});

  NoonRespone.fromJson(Map<String, dynamic> json) {
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
  List<Transactions>? transactions;
  Order? order;
  PaymentDetails? paymentDetails;

  Result(
      {this.nextActions, this.transactions, this.order, this.paymentDetails});

  Result.fromJson(Map<String, dynamic> json) {
    nextActions = json['nextActions'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(new Transactions.fromJson(v));
      });
    }
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    paymentDetails = json['paymentDetails'] != null
        ? new PaymentDetails.fromJson(json['paymentDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextActions'] = this.nextActions;
    if (this.transactions != null) {
      data['transactions'] = this.transactions!.map((v) => v.toJson()).toList();
    }
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.paymentDetails != null) {
      data['paymentDetails'] = this.paymentDetails!.toJson();
    }
    return data;
  }
}

class Transactions {
  String? type;
  String? authorizationCode;
  String? creationTime;
  String? status;
  int? amountRefunded;
  String? stan;
  String? rrn;
  String? id;
  int? amount;
  String? currency;

  Transactions(
      {this.type,
        this.authorizationCode,
        this.creationTime,
        this.status,
        this.amountRefunded,
        this.stan,
        this.rrn,
        this.id,
        this.amount,
        this.currency});

  Transactions.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    authorizationCode = json['authorizationCode'];
    creationTime = json['creationTime'];
    status = json['status'];
    amountRefunded = json['amountRefunded'];
    stan = json['stan'];
    rrn = json['rrn'];
    id = json['id'];
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['authorizationCode'] = this.authorizationCode;
    data['creationTime'] = this.creationTime;
    data['status'] = this.status;
    data['amountRefunded'] = this.amountRefunded;
    data['stan'] = this.stan;
    data['rrn'] = this.rrn;
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}

class Order {
  String? status;
  String? creationTime;
  int? totalAuthorizedAmount;
  int? totalCapturedAmount;
  int? totalRefundedAmount;
  int? totalRemainingAmount;
  int? totalReversedAmount;
  int? totalSalesAmount;
  int? errorCode;
  String? errorMesssage;
  int? id;
  int? amount;
  String? currency;
  String? name;
  String? reference;
  String? category;
  String? channel;

  Order(
      {this.status,
        this.creationTime,
        this.totalAuthorizedAmount,
        this.totalCapturedAmount,
        this.totalRefundedAmount,
        this.totalRemainingAmount,
        this.totalReversedAmount,
        this.totalSalesAmount,
        this.errorCode,
        this.errorMesssage,
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
    totalAuthorizedAmount = json['totalAuthorizedAmount'];
    totalCapturedAmount = json['totalCapturedAmount'];
    totalRefundedAmount = json['totalRefundedAmount'];
    totalRemainingAmount = json['totalRemainingAmount'];
    totalReversedAmount = json['totalReversedAmount'];
    totalSalesAmount = json['totalSalesAmount'];
    errorCode = json['errorCode'];
    errorMesssage= json['errorMessage'];
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
    data['totalAuthorizedAmount'] = this.totalAuthorizedAmount;
    data['totalCapturedAmount'] = this.totalCapturedAmount;
    data['totalRefundedAmount'] = this.totalRefundedAmount;
    data['totalRemainingAmount'] = this.totalRemainingAmount;
    data['totalReversedAmount'] = this.totalReversedAmount;
    data['totalSalesAmount'] = this.totalSalesAmount;
    data['errorCode'] = this.errorCode;
    data['errorMessage']=this.errorMesssage;
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

class PaymentDetails {
  String? instrument;
  String? tokenIdentifier;
  String? cardAlias;
  String? mode;
  String? integratorAccount;
  String? paymentInfo;
  String? brand;
  String? scheme;
  String? expiryMonth;
  String? expiryYear;
  String? isNetworkToken;
  String? cardType;
  String? cardCategory;
  String? cardCountry;
  String? cardCountryName;
  String? cardIssuerName;

  PaymentDetails(
      {this.instrument,
        this.tokenIdentifier,
        this.cardAlias,
        this.mode,
        this.integratorAccount,
        this.paymentInfo,
        this.brand,
        this.scheme,
        this.expiryMonth,
        this.expiryYear,
        this.isNetworkToken,
        this.cardType,
        this.cardCategory,
        this.cardCountry,
        this.cardCountryName,
        this.cardIssuerName});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    instrument = json['instrument'];
    tokenIdentifier = json['tokenIdentifier'];
    cardAlias = json['cardAlias'];
    mode = json['mode'];
    integratorAccount = json['integratorAccount'];
    paymentInfo = json['paymentInfo'];
    brand = json['brand'];
    scheme = json['scheme'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    isNetworkToken = json['isNetworkToken'];
    cardType = json['cardType'];
    cardCategory = json['cardCategory'];
    cardCountry = json['cardCountry'];
    cardCountryName = json['cardCountryName'];
    cardIssuerName = json['cardIssuerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instrument'] = this.instrument;
    data['tokenIdentifier'] = this.tokenIdentifier;
    data['cardAlias'] = this.cardAlias;
    data['mode'] = this.mode;
    data['integratorAccount'] = this.integratorAccount;
    data['paymentInfo'] = this.paymentInfo;
    data['brand'] = this.brand;
    data['scheme'] = this.scheme;
    data['expiryMonth'] = this.expiryMonth;
    data['expiryYear'] = this.expiryYear;
    data['isNetworkToken'] = this.isNetworkToken;
    data['cardType'] = this.cardType;
    data['cardCategory'] = this.cardCategory;
    data['cardCountry'] = this.cardCountry;
    data['cardCountryName'] = this.cardCountryName;
    data['cardIssuerName'] = this.cardIssuerName;
    return data;
  }
}
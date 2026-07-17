// To parse this JSON data, do
//
//     final orderSuccessModel = orderSuccessModelFromJson(jsonString);

import 'dart:convert';

OrderSuccessModel orderSuccessModelFromJson(String str) => OrderSuccessModel.fromJson(json.decode(str));

String orderSuccessModelToJson(OrderSuccessModel data) => json.encode(data.toJson());

class OrderSuccessModel {
  bool? success;
  Order? order;
  Recipient? recipient;

  OrderSuccessModel({
    this.success,
    this.order,
    this.recipient,
  });

  OrderSuccessModel copyWith({
    bool? success,
    Order? order,
    Recipient? recipient,
  }) =>
      OrderSuccessModel(
        success: success ?? this.success,
        order: order ?? this.order,
        recipient: recipient ?? this.recipient,
      );

  factory OrderSuccessModel.fromJson(Map<String, dynamic> json) => OrderSuccessModel(
    success: json["success"],
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    recipient: json["recipient"] == null ? null : Recipient.fromJson(json["recipient"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "order": order?.toJson(),
    "recipient": recipient?.toJson(),
  };
}

class Order {
  String? type;
  dynamic buyerId;
  String? projectId;
  int? recipientCount;
  int? totalAmount;
  String? paymentStatus;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Order({
    this.type,
    this.buyerId,
    this.projectId,
    this.recipientCount,
    this.totalAmount,
    this.paymentStatus,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Order copyWith({
    String? type,
    dynamic buyerId,
    String? projectId,
    int? recipientCount,
    int? totalAmount,
    String? paymentStatus,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) =>
      Order(
        type: type ?? this.type,
        buyerId: buyerId ?? this.buyerId,
        projectId: projectId ?? this.projectId,
        recipientCount: recipientCount ?? this.recipientCount,
        totalAmount: totalAmount ?? this.totalAmount,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
      );

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    type: json["type"],
    buyerId: json["buyerId"],
    projectId: json["projectId"],
    recipientCount: json["recipientCount"],
    totalAmount: json["totalAmount"],
    paymentStatus: json["paymentStatus"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "buyerId": buyerId,
    "projectId": projectId,
    "recipientCount": recipientCount,
    "totalAmount": totalAmount,
    "paymentStatus": paymentStatus,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Recipient {
  String? recipientName;
  String? recipientEmail;
  String? recipientPhone;
  String? status;
  String? queueEntryId;

  Recipient({
    this.recipientName,
    this.recipientEmail,
    this.recipientPhone,
    this.status,
    this.queueEntryId,
  });

  Recipient copyWith({
    String? recipientName,
    String? recipientEmail,
    String? recipientPhone,
    String? status,
    String? queueEntryId,
  }) =>
      Recipient(
        recipientName: recipientName ?? this.recipientName,
        recipientEmail: recipientEmail ?? this.recipientEmail,
        recipientPhone: recipientPhone ?? this.recipientPhone,
        status: status ?? this.status,
        queueEntryId: queueEntryId ?? this.queueEntryId,
      );

  factory Recipient.fromJson(Map<String, dynamic> json) => Recipient(
    recipientName: json["recipientName"],
    recipientEmail: json["recipientEmail"],
    recipientPhone: json["recipientPhone"],
    status: json["status"],
    queueEntryId: json["queueEntryId"],
  );

  Map<String, dynamic> toJson() => {
    "recipientName": recipientName,
    "recipientEmail": recipientEmail,
    "recipientPhone": recipientPhone,
    "status": status,
    "queueEntryId": queueEntryId,
  };
}

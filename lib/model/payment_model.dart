class PaymentModel{
  int? supplierPaymentsId;
  int? supplierId;
  String? payedAmountFromSupplierTotal;
  String? remainedAmountFromSupplierTotal;
  String? paymentDate;

  PaymentModel({
    this.supplierPaymentsId,
    this.supplierId,
    this.payedAmountFromSupplierTotal,
    this.remainedAmountFromSupplierTotal,
    this.paymentDate,
  });


  PaymentModel.fromJson(Map<String, dynamic> json) {
    supplierPaymentsId = json["supplier_payments_id"];
    supplierId = json["supplier_id"] is String ? int.parse(json["supplier_id"]) : json["supplier_id"];
    payedAmountFromSupplierTotal = json["payed_amount_from_supplier_total"];
    remainedAmountFromSupplierTotal = json["remained_amount_from_supplier_total"];
    paymentDate = json["payment_date"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["supplier_payments_id"] = supplierPaymentsId;
    data["supplier_id"] = supplierId;
    data["payed_amount_from_supplier_total"] = payedAmountFromSupplierTotal;
    data["remained_amount_from_supplier_total"] = remainedAmountFromSupplierTotal;
    data["payment_date"] = paymentDate;
    return data;
  }

}
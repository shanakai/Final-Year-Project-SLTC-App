
class Record {
  int? id;
  String? vehiclenumber;
  String? checkin;
  String? userid;
  bool? issCheckout;
  String? checkout;
  String? inDateTime;
  String? outDateTime;
  String? price;
  String? paymentStatus;

  Record(
      {this.id,
      this.vehiclenumber,
      this.checkin,
      this.userid,
      this.issCheckout,
      this.checkout,
      this.inDateTime,
      this.outDateTime,
      this.price,
      this.paymentStatus});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vehiclenumber = json['vehiclenumber'];
    checkin = json['checkin'];
    userid = json['userid'];
    issCheckout = json['issCheckout'];
    checkout = json['checkout'];
    inDateTime = json['inDateTime'];
    outDateTime = json['outDateTime'];
    price = json['price'];
    paymentStatus = json['paymentStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vehiclenumber'] = this.vehiclenumber;
    data['checkin'] = this.checkin;
    data['userid'] = this.userid;
    data['issCheckout'] = this.issCheckout;
    data['checkout'] = this.checkout;
    data['inDateTime'] = this.inDateTime;
    data['outDateTime'] = this.outDateTime;
    data['price'] = this.price;
    data['paymentStatus'] = this.paymentStatus;
    return data;
  }
}
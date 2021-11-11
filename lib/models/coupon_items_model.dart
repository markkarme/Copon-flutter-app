class CouponItems{
  String? logocompany,companyname,description,couponcode;
  CouponItems({
    required this.logocompany,
    required this.companyname,
    required this.description,
    required this.couponcode
  }); 
  CouponItems.fromJson(Map<String,dynamic> json){
    logocompany = json['logocompany'];
    companyname = json['companyname'];
    description= json['description'];
    couponcode = json['couponcode'];
  }
  Map<String,dynamic> toMap()=>{
    'logocompany':logocompany,
    'companyname':companyname,
    'description':description,
    'couponcode':couponcode,
  };
}
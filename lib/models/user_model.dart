class UserModel{
  String? name,email,uid;
  bool? isadmin;
  
  UserModel({required this.email,required this.name,required this.uid,this.isadmin=false});

 UserModel.fromJson(Map<String,dynamic> json){
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    isadmin = json['isadmin'];
  }
  
  Map<String,dynamic> toMap()=>{
    'name' : name,
    'email' : email,
    'uid' : uid,
    'isadmin' : isadmin,
  };

}
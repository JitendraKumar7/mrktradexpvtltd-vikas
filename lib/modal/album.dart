class Album {
 final String  type;
  final int Userid;
  String jobTitle;
 final int  konnect_id;
 final String cardType;
 final String corporate_konnect_id ;
 final String  referral_code;
 final int  numberOfRequest;
 final String  editCard;
 final String  konnect_logo;
 final String  organisation_name;
 final int item_id;
 final String  name;
 final String  designation;
 final String  konnect_cover_image;
 final String  youtube_link;
  final String mobileno;
  final String  Password;
final String regmobileno;
final String newpassword;
  final String Phone;
   String  Firstname;
  final String Lastname;
  final String Image;
  final String Email;
  Album({this.mobileno, this.Password,this.Userid,this.Image
    ,this.regmobileno,this.newpassword,
    this.Phone, this.Firstname,this.jobTitle
    ,this.Lastname,this.Email,
    this.youtube_link, this.konnect_cover_image
    ,this.designation,this.name,
    this.item_id, this.organisation_name
    ,this.konnect_logo,this.corporate_konnect_id,
    this.cardType, this.referral_code
    ,this.editCard,this.type,this.numberOfRequest,this.konnect_id,
  });
String get  First_name{
  return  Firstname;
}
set  First_name(String name){
  this.Firstname = name;
}
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(mobileno: json['mobile_number'],
      Userid: json['id'],
      jobTitle:json['job_title'],
      Image: json['image'],
      Password: json['password'],
    regmobileno: json['reg_mobile'],
    newpassword: json['new_password'],
      Phone: json['phone'],
      Firstname: json['firstname'],
      Lastname: json['lastname'],
      Email: json['email'],
youtube_link: json['youtube_link'],
organisation_name : json['organization_name'],
     numberOfRequest : json['numberOfRequest'],
   name  : json['name'],
  konnect_id  : json['konnect_id'],
  konnect_logo  : json['konnect_logo'],
   konnect_cover_image : json['konnect_cover_image'],
    cardType  : json['cardType '],
   corporate_konnect_id : json['corporate_konnect_id '],
   referral_code : json['referral_code'],
    editCard  : json['editCard '],
     type   : json[' type'],
     item_id   : json['item_id'] as int ,
     designation  : json['designation'],

    );
  }
}
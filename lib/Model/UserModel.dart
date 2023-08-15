class User{
  String? name;
  String? avatar;
  String? city;
  String? country;
  String? streetAddress;

User(this.name,this.avatar,this.city,this.country,this.streetAddress);

User.fromMap(Map<String, dynamic>m)
  : this(m["name"],m["avatar"],m["city"],m["country"],m["streetAddress"]);

Map<String, dynamic> toMap(){
return{'name':name, 'avatar': avatar, 'city': city, 'country': country, 'streetAddress': streetAddress};
}

}
class User{
  String id;
  String name;
  String avatar;
  String city;
  String country;
  String streetAddress;

User(this.id,this.name,this.avatar,this.city,this.country,this.streetAddress);

User.fromMap(Map<String, dynamic>m)
  : this(m["id"],m["name"],m["avatar"],m["city"],m["country"],m["streetAddress"]);

Map<String, dynamic> toMap(){
return{'id': id,'name':name, 'avatar': avatar, 'city': city, 'country': country, 'streetAddress': streetAddress};
}

}
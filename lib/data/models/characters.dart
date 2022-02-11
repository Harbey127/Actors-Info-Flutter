class Character {
  int? charId;
  String? actorName;
  String? currentName;
  String? img;

  List<dynamic>? occupation;
  String? status;
  String? birthday;

  List<dynamic>? appearance;

  String? portrayed;
  String? category;
  List<dynamic>? betterCallSaulAppearance;

  // Character({
  //   this.charId,
  //   this.name,
  //   this.birthday,
  //   this.occupation,
  //   this.img,
  //   this.status,
  //   this.appearance,
  //   this.nickname,
  //   this.portrayed,
  //   this.betterCallSaulAppearance,
  //
  //
  // });

  Character.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    currentName = json['name'];
    birthday = json['birthday'];
    occupation = json['occupation'];
    img = json['img'];
    status = json['status'];
    appearance = json['appearance'];
    actorName = json['nickname'];
    portrayed = json['portrayed'];
    category = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}

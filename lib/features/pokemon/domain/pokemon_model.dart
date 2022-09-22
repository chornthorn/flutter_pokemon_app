class PokemonModel {
  late final String name;
  late final String id;
  late final String imageurl;
  late final String xdescription;
  late final String ydescription;
  late final String height;
  late final String category;
  late final String weight;
  late final List<String> typeofpokemon;
  late final List<String> weaknesses;
  late final List<String> evolutions;
  late final List<String> abilities;
  late final int hp;
  late final int attack;
  late final int defense;
  late final int specialAttack;
  late final int specialDefense;
  late final int speed;
  late final int total;
  late final String? malePercentage;
  late final String? femalePercentage;
  late final int genderless;
  late final String cycles;
  late final String eggGroups;
  late final String evolvedfrom;
  late final String reason;
  late final String baseExp;

  PokemonModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    imageurl = json['imageurl'];
    xdescription = json['xdescription'];
    ydescription = json['ydescription'];
    height = json['height'];
    category = json['category'];
    weight = json['weight'];
    typeofpokemon = List.castFrom<dynamic, String>(json['typeofpokemon']);
    weaknesses = List.castFrom<dynamic, String>(json['weaknesses']);
    evolutions = List.castFrom<dynamic, String>(json['evolutions']);
    abilities = List.castFrom<dynamic, String>(json['abilities']);
    hp = json['hp'];
    attack = json['attack'];
    defense = json['defense'];
    specialAttack = json['special_attack'];
    specialDefense = json['special_defense'];
    speed = json['speed'];
    total = json['total'];
    malePercentage = json['male_percentage'];
    femalePercentage = json['female_percentage'];
    genderless = json['genderless'];
    cycles = json['cycles'];
    eggGroups = json['egg_groups'];
    evolvedfrom = json['evolvedfrom'];
    reason = json['reason'];
    baseExp = json['base_exp'];
  }
}

class BeeInfoModel {
//moduł opony
  int _id;
  String _name;
  int _hivesNumber;
  int _year;
  String _beekeeper;
  int _beekeeperNumber;
  String _character;
  String _district;


  // Constructor
  BeeInfoModel(this._name, this. _hivesNumber, this._year,
      this._beekeeper, this._beekeeperNumber,  this._character,  this._district);
  BeeInfoModel.withId(this._id, this._name, this. _hivesNumber, this._year,
      this._beekeeper, this._beekeeperNumber,  this._character,  this._district);

  // getters
  int get id => _id;
  String get name => _name;
  int get hivesNumber => _hivesNumber;
  int get year => _year;
  String get beekeeper => _beekeeper;
  int get beekeeperNumber => _beekeeperNumber;
  String get character => _character;
  String get district => _district;

  // setters
  set name(String newName) {
    if (newName.length <= 255) {
      _name = newName;
    }
  }

  set hivesNumber(int newHivesNumber) {
      _hivesNumber = newHivesNumber;
  }

  set year(int newYear) {
      _year = newYear;
  }

  set beekeeper(String newBeekeeper) {
    if (newBeekeeper.length <= 255) {
      _beekeeper = newBeekeeper;
    }
  }

  set beekeeperNumber(int newBeekeeperNumber){
      _beekeeperNumber = newBeekeeperNumber;
  }

   set character(String newCharacter) {
    if (newCharacter.length <= 255) {
      _character = newCharacter;
    }
  }

   set district(String newDistrict) {
    if (newDistrict.length <= 255) {
      _district = newDistrict;
    }
  }

  Map<String, dynamic> toMap() {
    var beeinfoMap = Map<String, dynamic>();
    beeinfoMap['name'] = _name;
    beeinfoMap['hivesNumber'] = _hivesNumber;
    beeinfoMap['year'] = _year;
    beeinfoMap['beekeeper'] = _beekeeper;
    beeinfoMap['beekeeperNumber'] = _beekeeperNumber;
    beeinfoMap['character'] = _character;
    beeinfoMap['district'] = _district;
    if (_id != null) {
      beeinfoMap['id'] = _id;
    }
    return beeinfoMap;
  }
}

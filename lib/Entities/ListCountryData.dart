import 'package:covidnumbers/Entities/CountryData.dart';

class ListCountryData {
  final List<CountryData> countryDatas;

  ListCountryData({this.countryDatas});

  factory ListCountryData.fromJson(List<dynamic> parsedJson) {

    List<CountryData> countryDatas = new List<CountryData>();
    countryDatas = parsedJson.map((i)=>CountryData.fromJson(i)).toList();

    countryDatas.sort((a, b) => a.infectionFactor.compareTo(b.infectionFactor));
    int counter = 1;
    countryDatas.forEach((element){
      element.rank = counter;
      counter = counter + 1;
    });

    return new ListCountryData(
        countryDatas: countryDatas
    );
  }
}
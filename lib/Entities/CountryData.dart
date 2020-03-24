import 'package:covidnumbers/Entities/Numbers.dart';

class CountryData {

  final String province;
  final String countryName;
  final double lat;
  final double lng;
  final String lastUpdate;
  final List<Numbers> numbers;
  int totalDaysInfected = 0;
  double infectionFactor = 0.0;
  int rank = 1;


  CountryData({
    this.province,
    this.countryName,
    this.lat,
    this.lng,
    this.lastUpdate,
    this.numbers,
    this.totalDaysInfected,
    this.infectionFactor,
    this.rank
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {

    List<Numbers> list = [];
    var mapTimeSeries = json['timeseries'] as Map<String, dynamic>;
    mapTimeSeries.forEach((k, v) => list.add(Numbers(date: k, confirmed: v['confirmed'], deaths: v['deaths'], recovered: v['recovered'])));

    int daysInfected = 0;
    double sumFactor = 0;
    var confirmedFactor = new List<double>();
    double confirmedCasesDayBefore = 0;
    var confirmedNewCases = new List<double>();

    list.forEach((day) {
      confirmedNewCases.add(day.confirmed.toDouble() - confirmedCasesDayBefore);
      if (day.confirmed > 0) {
        daysInfected = daysInfected + 1;

        if (confirmedCasesDayBefore > 0) {
          confirmedFactor.add(
              day.confirmed.toDouble() / confirmedCasesDayBefore);
          sumFactor =
              sumFactor + (day.confirmed.toDouble() / confirmedCasesDayBefore);
        }
      }

      confirmedCasesDayBefore = day.confirmed.toDouble();
    });

    double infectFactor = sumFactor / confirmedFactor.length;

    return CountryData(
      province: json['provincestate'],
      countryName: json['countryregion'],
      lat: json['location']['lat'].toDouble(),
      lng: json['location']['lng'].toDouble(),
      lastUpdate: json['lastupdate'],
      numbers: list,
      totalDaysInfected: daysInfected,
      infectionFactor: infectFactor,
      rank: 1
    );
  }
}
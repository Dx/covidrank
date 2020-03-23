import 'package:covidnumbers/Entities/Numbers.dart';

class CountryData {

  final String province;
  final String countryName;
  final double lat;
  final double lng;
  final String lastUpdate;
  final List<Numbers> numbers;
  int totalDaysInfected = 0;
  int populationDensity = 0;
  double confirmedRank = 0.0;
  double deathsRank = 0.0;
  double recoveredRank = 0.0;
  double score = 0.0;
  int rank = 1;


  CountryData({
    this.province,
    this.countryName,
    this.lat,
    this.lng,
    this.lastUpdate,
    this.numbers,
    this.totalDaysInfected,
    this.populationDensity,
    this.confirmedRank,
    this.deathsRank,
    this.recoveredRank,
    this.score,
    this.rank
  });

  factory CountryData.fromJson(Map<String, dynamic> json) {

    List<Numbers> list = [];
    var mapTimeSeries = json['timeseries'] as Map<String, dynamic>;
    mapTimeSeries.forEach((k, v) => list.add(Numbers(date: k, confirmed: v['confirmed'], deaths: v['deaths'], recovered: v['recovered'])));

    int daysInfected = 0;
    list.forEach((day) {
      if (day.confirmed > 0) {
        daysInfected = daysInfected + 1;
      }
    });

    int density = 0;
    switch(json['countryregion']) {
      case 'Afghanistan':
        { density = 49; } break;
      case 'Albania':
        { density = 100; } break;
      case 'Algeria':
        { density = 18; } break;
      case 'Andorra':
        { density = 164; } break;
      case 'Angola':
        { density = 2; } break;
      case 'Antigua and Barbuda':
        { density = 235; } break;
      case 'Argentina':
        { density = 16; } break;
      case 'Armenia':
        { density = 21; } break;
      case 'Australia':
        { density = 3; } break;
      case 'Austria':
        { density = 106; } break;
      case 'Azerbaijan':
        { density = 116; } break;
      case 'Bahamas, The':
        { density = 28; } break;
      case 'Bahrain':
        { density = 1983; } break;
      case 'Bangladesh':
        { density = 1169; } break;
      case 'Barbados':
        { density = 668; } break;
      case 'Belarus':
        { density = 46; } break;
      case 'Belgium':
        { density = 376; } break;
      case 'Belize':
        { density = 17; } break;
      case 'Benin':
        { density = 104; } break;
      case 'Bhutan':
        { density = 21; } break;
      case 'Bolivia':
        { density = 10; } break;
      case 'Bosnia and Herzegovina':
        { density = 69; } break;
      case 'Botswana':
        { density = 4; } break;
      case 'Brazil':
        { density = 25; } break;
      case 'Brunei':
        { density = 73; } break;
      case 'Bulgaria':
        { density = 63; } break;
      case 'Burkina Faso':
        { density = 75; } break;
      case 'Burundi':
        { density = 403; } break;
      case 'Cambodia':
        { density = 90; } break;
      case 'Cameroon':
        { density = 52; } break;
      case 'Canada':
        { density = 56; } break;
      case 'Cape Verde':
        { density = 136; } break;
      case 'Central African Republic':
        { density = 8; } break;
      case 'Chad':
        { density = 12; } break;
      case 'Chile':
        { density = 23; } break;
      case 'China':
        { density = 145; } break;
      case 'Colombia':
        { density = 40; } break;
      case 'Congo (Brazzaville)':
        { density = 1; } break;
      case 'Congo (Kinshasa)':
        { density = 1; } break;
      case 'Costa Rica':
        { density = 99; } break;
      case 'Cote d''Ivore':
        { density = 1; } break;
      case 'Croatia':
        { density = 72; } break;
      case 'Cuba':
        { density = 102; } break;
      case 'Cyprus':
        { density = 149; } break;
      case 'Czechia':
        { density = 135; } break;
      case 'Denmark':
        { density = 135; } break;
      case 'Djibouti':
        { density = 47; } break;
      case 'Dominican Republic':
        { density = 216; } break;
      case 'East Timor':
        { density = 1; } break;
      case 'Ecuador':
        { density = 63; } break;
      case 'Egypt':
        { density = 100; } break;
      case 'El Salvador':
        { density = 319; } break;
      case 'Equatorial Guinea':
        { density = 48; } break;
      case 'Eritrea':
        { density = 29; } break;
      case 'Estonia':
        { density = 29; } break;
      case 'Eswatini':
        { density = 67; } break;
      case 'Ethiopia':
        { density = 101; } break;
      case 'Fiji':
        { density = 48; } break;
      case 'Finland':
        { density = 16; } break;
      case 'France':
        { density = 123; } break;
      case 'Gabon':
        { density = 8; } break;
      case 'Gambia, The':
        { density = 208; } break;
      case 'Germany':
        { density = 233; } break;
      case 'Ghana':
        { density = 127; } break;
      case 'Greece':
        { density = 81; } break;
      case 'Guatemala':
        { density = 162; } break;
      case 'Guinea':
        { density = 50; } break;
      case 'Guyana':
        { density = 4; } break;
      case 'Haiti':
        { density = 416; } break;
      case 'Holy See':
        { density = 1; } break;
      case 'Honduras':
        { density = 81; } break;
      case 'Hungary':
        { density = 105; } break;
      case 'Iceland':
        { density = 4; } break;
      case 'India':
        { density = 414; } break;
      case 'Indonesia':
        { density = 141; } break;
      case 'Iran':
        { density = 51; } break;
      case 'Iraq':
        { density = 90; } break;
      case 'Ireland':
        { density = 70; } break;
      case 'Israel':
        { density = 416; } break;
      case 'Italy':
        { density = 200; } break;
      case 'Jamaica':
        { density = 248; } break;
      case 'Japan':
        { density = 333; } break;
      case 'Jordan':
        { density = 119; } break;
      case 'Jazakhstan':
        { density = 7; } break;
      case 'Kenya':
        { density = 82; } break;
      case 'Korea, South':
        { density = 517; } break;
      case 'Kosovo':
        { density = 165; } break;
      case 'Kuwait':
        { density = 248; } break;
      case 'Kyrgyztan':
        { density = 32; } break;
      case 'Latvia':
        { density = 30; } break;
      case 'Lebanon':
        { density = 672; } break;
      case 'Liberia':
        { density = 46; } break;
      case 'Liechtenstein':
        { density = 240; } break;
      case 'Lithuania':
        { density = 43; } break;
      case 'Luxembourg':
        { density = 237; } break;
      case 'Madagascar':
        { density = 2; } break;
      case 'Malaysia':
        { density = 99; } break;
      case 'Maldives':
        { density = 1258; } break;
      case 'Malta':
        { density = 1510; } break;
      case 'Martinique':
        { density = 329; } break;
      case 'Mauritania':
        { density = 4; } break;
      case 'Mauritius':
        { density = 620; } break;
      case 'Mexico':
        { density = 64; } break;
      case 'Moldova':
        { density = 79; } break;
      case 'Monaco':
        { density = 18960; } break;
      case 'Mongolia':
        { density = 2; } break;
      case 'Montenegro':
        { density = 45; } break;
      case 'Morocco':
        { density = 80; } break;
      case 'Namibia':
        { density = 3; } break;
      case 'Nepal':
        { density = 201; } break;
      case 'Netherlands':
        { density = 420; } break;
      case 'New Zealand':
        { density = 18; } break;
      case 'Nicaragua':
        { density = 53; } break;
      case 'Niger':
        { density = 19; } break;
      case 'Nigeria':
        { density = 218; } break;
      case 'North Macedonia':
        { density = 81; } break;
      case 'Norway':
        { density = 17; } break;
      case 'Oman':
        { density = 14; } break;
      case 'Pakistan':
        { density = 272; } break;
      case 'Panama':
        { density = 56; } break;
      case 'Papua New Guinea':
        { density = 19; } break;
      case 'Paraguay':
        { density = 17; } break;
      case 'Peru':
        { density = 25; } break;
      case 'Philippines':
        { density = 361; } break;
      case 'Poland':
        { density = 123; } break;
      case 'Portugal':
        { density = 112; } break;
      case 'Qatar':
        { density = 237; } break;
      case 'Romania':
        { density = 81; } break;
      case 'Russia':
        { density = 9; } break;
      case 'Rwanda':
        { density = 470; } break;
      case 'Saint Lucia':
        { density = 292; } break;
      case 'Saint Vincent and the Grenadines':
        { density = 284; } break;
      case 'San Marino':
        { density = 568; } break;
      case 'Saudi Arabia':
        { density = 16; } break;
      case 'Senegal':
        { density = 82; } break;
      case 'Serbia':
        { density = 89; } break;
      case 'Seychelles':
        { density = 213; } break;
      case 'Singapore':
        { density = 7894; } break;
      case 'Slovakia':
        { density = 111; } break;
      case 'Slovenia':
        { density = 103; } break;
      case 'Somalia':
        { density = 24; } break;
      case 'South Africa':
        { density = 48; } break;
      case 'Spain':
        { density = 93; } break;
      case 'Sri Lanka':
        { density = 332; } break;
      case 'Sudan':
        { density = 22; } break;
      case 'Suriname':
        { density = 4; } break;
      case 'Sweden':
        { density = 23; } break;
      case 'Switzerland':
        { density = 208; } break;
      case 'Taiwan*':
        { density = 652; } break;
      case 'Tanzania':
        { density = 59; } break;
      case 'Thailand':
        { density = 130; } break;
      case 'Togo':
        { density = 133; } break;
      case 'Trinidad and Tobago':
        { density = 265; } break;
      case 'Tunisia':
        { density = 72; } break;
      case 'Turkey':
        { density = 106; } break;
      case 'US':
        { density = 34; } break;
      case 'Uganda':
        { density = 166; } break;
      case 'Ukraine':
        { density = 69; } break;
      case 'United Arab Emirates':
        { density = 117; } break;
      case 'United Kingdom':
        { density = 274; } break;
      case 'Uruguay':
        { density = 20; } break;
      case 'Uzbekistan':
        { density = 73; } break;
      case 'Venezuela':
        { density = 35; } break;
      case 'Vietnam':
        { density = 290; } break;
      case 'Zambia':
        { density = 22; } break;
      case 'Zumbabwe':
        { density = 39; } break;
    }

    double confirmedRankTemp = 0;
    double deathsRankTemp = 0;
    double recoveredRankTemp = 0;
    if (daysInfected > 0 && density > 0) {
      confirmedRankTemp = (list.last.confirmed/density)/daysInfected;
      deathsRankTemp = (list.last.deaths/density)/daysInfected;
      recoveredRankTemp = (list.last.recovered/density)/daysInfected;
    }

    double scoreTemp = 0;
    if (confirmedRankTemp*deathsRankTemp > 0) {
      scoreTemp = recoveredRankTemp/(confirmedRankTemp*deathsRankTemp);
    }

    return CountryData(
      province: json['provincestate'],
      countryName: json['countryregion'],
      lat: json['location']['lat'].toDouble(),
      lng: json['location']['lng'].toDouble(),
      lastUpdate: json['lastupdate'],
      numbers: list,
      totalDaysInfected: daysInfected,
      populationDensity: density,
      confirmedRank: confirmedRankTemp,
      deathsRank: deathsRankTemp,
      recoveredRank: recoveredRankTemp,
      score: scoreTemp,
      rank: 1
    );
  }
}
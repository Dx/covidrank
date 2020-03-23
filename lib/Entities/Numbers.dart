class Numbers {
  final String date;
  final int confirmed;
  final int deaths;
  final int recovered;
  int totalDaysInfected = 0;
  int populationDensity = 0;
  double confirmedRank = 0.0;
  double deathsRank = 0.0;
  double recoveredRank = 0.0;
  double score = 0.0;

  Numbers({this.date,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.totalDaysInfected,
    this.populationDensity,
    this.confirmedRank,
    this.deathsRank,
    this.recoveredRank,
    this.score});

  factory Numbers.fromJson(Map<String, dynamic> json) {
    return Numbers(
      date: json.keys.first,
      confirmed: json['confirmed'],
      deaths: json['deaths'],
      recovered: json['recovered'],
    );
  }
}
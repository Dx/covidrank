import 'package:covidnumbers/Entities/CountryData.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Comparison extends StatefulWidget {

  @override
  _ComparisonState createState() => _ComparisonState();
}

class _ComparisonState extends State<Comparison> {

  @override
  Widget build(BuildContext context) {

    final CountryData args = ModalRoute.of(context).settings.arguments;
    var confirmedData = new List<double>();
    var deathData = new List<double>();
    var recoveredData = new List<double>();
    var daysInfected = 0;

    double confirmedCasesDayBefore = 0;
    var confirmedNewCases = new List<double>();

    var confirmedFactor = new List<double>();

    double deathCasesDayBefore = 0;
    var deathNewCases = new List<double>();

    double recoveredCasesDayBefore = 0;
    var recoveredNewCases = new List<double>();

    double sumFactor = 0;

    args.numbers.forEach((day) {
      if (day.confirmed >= 1) {
        confirmedData.add(day.confirmed.toDouble());
        deathData.add(day.deaths.toDouble());
        recoveredData.add(day.recovered.toDouble());

        confirmedNewCases.add(day.confirmed.toDouble() - confirmedCasesDayBefore);
        if (confirmedCasesDayBefore > 0) {

          confirmedFactor.add(day.confirmed.toDouble() / confirmedCasesDayBefore);
          sumFactor = sumFactor + (day.confirmed.toDouble() / confirmedCasesDayBefore);
          print('confirmedCasesDayBefore: ' + confirmedCasesDayBefore.toString());
          print('confirmedCasesThisDay: ' + day.confirmed.toDouble().toString());
          print('sumFactor: ' + sumFactor.toString());
        }

        confirmedCasesDayBefore = day.confirmed.toDouble();

        deathNewCases.add(day.deaths.toDouble() - deathCasesDayBefore);
        deathCasesDayBefore = day.deaths.toDouble();

        recoveredNewCases.add(day.recovered.toDouble() - recoveredCasesDayBefore);
        recoveredCasesDayBefore = day.recovered.toDouble();

        daysInfected = daysInfected + 1;
      }
    });

//    double infectionFactor = confirmedFactor.last;
    double infectionFactor = sumFactor / confirmedFactor.length;

    const List<StaggeredTile> _tiles = const <StaggeredTile>[
      const StaggeredTile.count(2, 0.30),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(1, 0.8),
      const StaggeredTile.count(1, 0.8),
      const StaggeredTile.count(2, 1),
      const StaggeredTile.count(2, 0.8),
    ];

    Widget confirmedChart = new Sparkline(
      data: confirmedData,
      lineColor: Colors.white,
      pointsMode: PointsMode.all,
      pointColor: Colors.white,
      pointSize: 8.0,
    );

    Widget deathChart = new Sparkline(
      data: deathData,
      lineColor: Colors.white,
      pointsMode: PointsMode.all,
      pointColor: Colors.white,
      pointSize: 8.0,
    );

    Widget recoveredChart = new Sparkline(
      data: recoveredData,
      lineColor: Colors.white,
      pointsMode: PointsMode.all,
      pointColor: Colors.white,
      pointSize: 8.0,
    );

    Widget confirmedNewChart = new Sparkline(
      data: confirmedNewCases,
      lineColor: Colors.white,
      pointsMode: PointsMode.all,
      pointColor: Colors.white,
      pointSize: 8.0,
    );

    Widget deathNewChart = new Sparkline(
      data: deathNewCases,
      lineColor: Colors.white,
      pointsMode: PointsMode.all,
      pointColor: Colors.white,
      pointSize: 8.0,
    );

    Widget recoveredNewChart = new Sparkline(
      data: recoveredNewCases,
      lineColor: Colors.white,
      pointsMode: PointsMode.all,
      pointColor: Colors.white,
      pointSize: 8.0,
    );

    List<Widget> _children = <Widget>[
      const HomeHeaderTile('Infection behavior', Colors.indigo),
      HomeTile('Confirmed accum', confirmedChart, Colors.indigo),
      HomeTile('Confirmed new cases', confirmedNewChart, Colors.indigo),
      HomeTile('Death accum', deathChart, Colors.red),
      HomeTile('Death new cases', deathNewChart, Colors.red),
      HomeTile('Recovered accum', recoveredChart, Colors.blue),
      HomeTile('Recovered new cases', recoveredNewChart, Colors.blue),
      HomeTile('Days with infection',
        Text(args.totalDaysInfected.toString(),
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200]
            )
        ),
        Colors.deepOrangeAccent),
      HomeTile('Infection factor',
        Text(infectionFactor.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.grey[200]
          )
        ),
        Colors.brown),
      HomeTile('Rank in list',
        Text(args.rank.toString(),
          style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200]
          )
        ),
        Colors.green
      ),
      HomeDescription(
        'The Infection factor considered on the ranking, is based on the new confirmed cases day after day. \n The ideal is 1, bigger than 1 is more dangerous. \n\nContact dequis@gmail.com',
        Colors.lightGreen
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          args.countryName,
        ),
        centerTitle: true,
      ),
      body: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.local_hospital, color: Colors.grey[700],),
                SizedBox(width: 5),
                Text(confirmedData.last.toStringAsFixed(0)),
                SizedBox(width: 30),
                Icon(Icons.sentiment_very_dissatisfied, color: Colors.grey[700],),
                SizedBox(width: 5),
                Text(deathData.last.toStringAsFixed(0)),
                SizedBox(width: 30),
                Icon(Icons.healing, color: Colors.grey[700],),
                SizedBox(width: 5),
                Text(recoveredData.last.toStringAsFixed(0)),
              ],
            ),
            Expanded(
              child: new StaggeredGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              children: _children,
              staggeredTiles: _tiles,
              ),
            ),
          ],
        ),
    ));
  }
}

class HomeHeaderTile extends StatelessWidget {
  const HomeHeaderTile(this.title, this.backgroundColor);

  final String title;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
          border: new Border(
              bottom: new BorderSide(
                color: backgroundColor,
              ))),
      child: new Align(
        alignment: Alignment.bottomCenter,
        child: new Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .primaryTextTheme
                .title
                .copyWith(color: backgroundColor),
          ),
        ),
      ),
    );
  }
}

class HomeTile extends StatelessWidget {
  const HomeTile(this.title, this.child, this.color);
  final String title;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: color,
      child: new InkWell(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
                ),
              ),
              new Center(
                child: new Padding(
                    padding: EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 5.0),
                    child: child
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}

class HomeDescription extends StatelessWidget {
  const HomeDescription(this.title, this.color);
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: color,
      child: InkWell(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
              ),
            ),
          ),
        ),
      ),
    );
  }
}

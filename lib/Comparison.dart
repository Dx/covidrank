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
    args.numbers.forEach((day) {
      if (day.confirmed >= 1) {
        confirmedData.add(day.confirmed.toDouble());
        deathData.add(day.deaths.toDouble());
        recoveredData.add(day.recovered.toDouble());
        daysInfected = daysInfected + 1;
      }
    });

    const List<StaggeredTile> _tiles = const <StaggeredTile>[
      const StaggeredTile.count(2, 0.30),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(1, 1),
      const StaggeredTile.count(2, 1),
      const StaggeredTile.count(1, 0.8),
      const StaggeredTile.count(1, 0.8),
      const StaggeredTile.count(2, .8),
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

    List<Widget> _children = <Widget>[
      const HomeHeaderTile('Infection behavior', Colors.indigo),
      HomeTile('Confirmed', confirmedChart, Colors.indigo),
      HomeTile('Death', deathChart, Colors.red),
      HomeTile('Recovered', recoveredChart, Colors.blue),
      HomeTile('Days with infection',
        Text(args.totalDaysInfected.toString(),
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200]
            )
        ),
        Colors.deepOrangeAccent),
      HomeTile('Density (people/km2)',
        Text(args.populationDensity.toString(),
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: Colors.grey[200]
          )
        ),
        Colors.brown),
      HomeTile('Total score', Text(args.score.toStringAsFixed(2),
          style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.grey[200]
          )
      ),
          Colors.green),
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
                Text(confirmedData.last.toString()),
                SizedBox(width: 30),
                Icon(Icons.sentiment_very_dissatisfied, color: Colors.grey[700],),
                SizedBox(width: 5),
                Text(deathData.last.toString()),
                SizedBox(width: 30),
                Icon(Icons.healing, color: Colors.grey[700],),
                SizedBox(width: 5),
                Text(recoveredData.last.toString()),
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
                  padding: EdgeInsets.fromLTRB(18.0, 15.0, 18.0, 5.0),
                  child: child
              ),
            ),
          ],
        )
      ),
    );
  }
}

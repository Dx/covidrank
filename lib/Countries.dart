import 'package:covidnumbers/Entities/ListCountryData.dart';
import 'package:covidnumbers/Entities/CountryData.dart';
import 'package:covidnumbers/Comparison.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Countries extends StatefulWidget {
  @override
  _CountriesState createState() => _CountriesState();
}

class _CountriesState extends State<Countries> {

  List<CountryData> listCountries;
  TextEditingController controller = new TextEditingController();
  String filter = '';

  Future<ListCountryData> getData() async {

    final response =
    await http.get('https://wuhan-coronavirus-api.laeyoung.endpoint.ainize.ai/jhu-edu/timeseries?onlyCountries=true');

    if (response.statusCode == 200) {
      var list = ListCountryData.fromJson(json.decode(response.body));
      return list;
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Covid 19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Covid 19'),
        ),
        body: Column(
          children: <Widget>[
            TextField(
              decoration: new InputDecoration(
                  labelText: "Search a country"
              ),
              controller: controller,
            ),
            Expanded(
              child: FutureBuilder<ListCountryData>(
                future: getData(),
                builder: (context, snapshot) {

                  if (snapshot.hasData) {
                    List<CountryData> data = snapshot.data.countryDatas;
                    if (filter != null || filter != '') {
                      data = data.where((e) => e.countryName.toLowerCase().startsWith(filter.toLowerCase())).toList();
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        CountryData countryData = data[index];
                        String countryName = '';

                        countryName = countryData.countryName;
                        //print(countryName);
                        if (countryName.length > 22) {
                          countryName = countryName.substring(0, 22);
                          print(countryName);
                        }

                        return GestureDetector(
                          onTap: () {
                            print('tapped');
                            Navigator.push(
                                context,
                                new MaterialPageRoute<String>(
                                  builder: (
                                      BuildContext context) => new Comparison(),
                                  fullscreenDialog: true,
                                  settings: RouteSettings(
                                    arguments: countryData,
                                  ),
                                )
                            );
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 15),
                                  Text(countryData.rank.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Text(countryName,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  IconButton(
                                    icon: Icon(Icons.insert_chart),
                                    color: Colors.blue,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          new MaterialPageRoute<String>(
                                            builder: (BuildContext context) => new Comparison(),
                                            fullscreenDialog: true,
                                            settings: RouteSettings(
                                              arguments: countryData,
                                            ),
                                          )
                                      );
                                      //Navigator.of(context).pushNamed('/detail', arguments: { 'data': countryData });
                                    },
                                  ),
                                  //Text(countryData.score.toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: 50),
                                  Icon(Icons.local_hospital, color: Colors.grey[700],),
                                  SizedBox(width: 4),
                                  Text(countryData.numbers.last.confirmed.toString()),
                                  SizedBox(width: 25),
                                  Icon(Icons.sentiment_very_dissatisfied, color: Colors.grey[700],),
                                  SizedBox(width: 4),
                                  Text(countryData.numbers.last.deaths.toString()),
                                  SizedBox(width: 25),
                                  Icon(Icons.healing, color: Colors.grey[700],),
                                  SizedBox(width: 4),
                                  Text(countryData.numbers.last.recovered.toString()),
                                  SizedBox(width: 25),
                                  Icon(Icons.today, color: Colors.grey[700],),
                                  SizedBox(width: 4),
                                  Text(countryData.totalDaysInfected.toString()),
                                ],
                              ),
                              Divider(
                                color: Colors.blue[200],
                              ),
                            ],
                          ),
                        );
                      }
                    );

                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // Por defecto, muestra un loading spinner
                  return Center(child: CircularProgressIndicator());

                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

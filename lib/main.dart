import 'package:covid_web/blocs/bloc/summary_bloc.dart';
import 'package:covid_web/networking/summary_api_client.dart';
import 'package:covid_web/repositories/summary_repository.dart';
import 'package:covid_web/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SummaryRepository repository = SummaryRepository(SummaryApiClient());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => SummaryBloc(repository),
        child: MyHomePage(),
      ),
    );
  }
}

class LoadedState extends StatelessWidget {
  const LoadedState({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: Colors.red[200],
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          children: [
            Row(
              children: [
                TitleWidget(),
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 10),
                StatsCard('INFECTED', '17865290', Icons.ac_unit),
                SizedBox(width: 10),
                StatsCard('DEATHS', '5461287', Icons.settings_power),
                SizedBox(width: 10),
                StatsCard('RECOVERED', '2974583', Icons.healing),
                SizedBox(width: 10),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  final String title, number;
  final IconData icon;

  StatsCard(this.title, this.number, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // margin: EdgeInsets.all(10),
        width: 170,
        height: 120,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              number,
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      // color: Colors.red[100],
      child: Text(
        'COVID-19',
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }
}

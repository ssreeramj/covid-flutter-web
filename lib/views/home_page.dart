import 'package:covid_web/blocs/bloc/summary_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SummaryBloc, SummaryState>(
      builder: (context, state) {
        if (state is SummaryInitial) {
          BlocProvider.of<SummaryBloc>(context).add(FetchDetails());
        }
        if (state is SummaryError) {
          return Center(
            child: Text(
              'Unable to load data',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }
        if (state is SummaryLoaded) {
          return LoadedState(
            state.summary.cases,
            state.summary.deaths,
            state.summary.recovered,
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class LoadedState extends StatelessWidget {
  final int infected, deaths, recovered;

  LoadedState(this.infected, this.deaths, this.recovered);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
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
                  StatsCard('INFECTED', infected.toString(), Icons.ac_unit),
                  SizedBox(width: 10),
                  StatsCard('DEATHS', deaths.toString(), Icons.settings_power),
                  SizedBox(width: 10),
                  StatsCard('RECOVERED', recovered.toString(), Icons.healing),
                  SizedBox(width: 10),
                ],
              )
            ],
          ),
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

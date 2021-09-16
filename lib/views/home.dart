import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ptsganjil202112rpl2alga4/models/team_model.dart';
import 'package:ptsganjil202112rpl2alga4/shared/loading.dart';
import 'package:ptsganjil202112rpl2alga4/views/lists/stadium_list.dart';
import 'package:ptsganjil202112rpl2alga4/views/lists/team_list.dart';
import 'package:ptsganjil202112rpl2alga4/models/stadium_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<TeamModel> teamList = [];
  late List<StadiumModel> stadiumList = [];
  late List<dynamic> data;
  bool isLoading = false;

  Future<void> getTeams() async {
    setState(() {
      isLoading = true;
    });

    final response = await get(Uri.parse(
        'https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League'));

    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var res = jsonDecode(response.body);
      if (this.mounted) {
        setState(() {
          data = res['teams'];
          for (int i = 0; i < data.length; i++) {
            teamList.add(new TeamModel(
                data[i]['strTeam'],
                data[i]['strStadium'],
                data[i]['strCountry'],
                data[i]['strDescriptionEN'],
                data[i]['strTeamBadge'],
                data[i]['intFormedYear']));
            stadiumList.add(new StadiumModel(
                data[i]['strStadium'],
                data[i]['strStadiumLocation'],
                data[i]['strTeam'],
                data[i]['strStadiumDescription'],
                data[i]['strStadiumThumb'],
                data[i]['intStadiumCapacity']));
          }
        });
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load teams');
    }
  }

  @override
  void initState() {
    super.initState();
    getTeams();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: isLoading
          ? Loading() : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Text('Everything you need to know about soccer!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18))),
                        Expanded(
                          child: Image.asset('assets/soccer_home.png'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Flexible(fit: FlexFit.loose, child: TeamList(list: teamList)),
              SizedBox(height: 30),
              Flexible(fit: FlexFit.loose, child: StadiumList(list: stadiumList)),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

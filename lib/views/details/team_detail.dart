import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2alga4/models/team_model.dart';

class TeamDetail extends StatelessWidget {
  final TeamModel team;

  const TeamDetail({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Team Detail')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Flexible(fit: FlexFit.loose, child: Center(child: Image.network(team.strTeamBadge, height: 150))),
            SizedBox(height: 30),
            Flexible(fit: FlexFit.loose, child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text('Team', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text(team.strTeam)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text('Stadium', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text(team.strStadium)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text('Formed in', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text(team.intFormedYear)),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text('Country', style: TextStyle(fontWeight: FontWeight.bold))),
                        Expanded(child: Text(team.strCountry)),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(height: 5),
                        Text(team.strDescriptionEN),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

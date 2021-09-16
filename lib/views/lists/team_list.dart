import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2alga4/models/team_model.dart';
import 'package:ptsganjil202112rpl2alga4/views/details/team_detail.dart';

class TeamList extends StatelessWidget {
  final List<TeamModel> list;

  const TeamList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(fit: FlexFit.loose, child: Text('TEAMS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))),
            SizedBox(height: 10),
            Flexible(fit: FlexFit.loose, child: Container(height: 130, child: _buildList(list)))
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<TeamModel> list) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          TeamModel team = list[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            elevation: 3,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TeamDetail(team: team)));
              },
              child: Container(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Expanded(flex: 3, child: Image.network(team.strTeamBadge)),
                      SizedBox(height: 5),
                      Text(team.strTeam, style: TextStyle(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}

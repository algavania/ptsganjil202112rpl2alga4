import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2alga4/models/stadium_model.dart';
import 'package:ptsganjil202112rpl2alga4/views/details/stadium_detail.dart';

class StadiumList extends StatelessWidget {
  final List<StadiumModel> list;

  const StadiumList({Key? key, required this.list}) : super(key: key);

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
            Flexible(fit: FlexFit.loose, child: Text('STADIUMS', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor))),
            SizedBox(height: 10),
            Flexible(fit: FlexFit.loose, child: Container(height: 150, child: _buildList(list)))
          ],
        ),
      ),
    );
  }

  Widget _buildList(List<StadiumModel> list) {
    return ListView.builder(
        itemCount: list.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          StadiumModel stadium = list[index];
          return Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            elevation: 3,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StadiumDetail(stadium: stadium)));
              },
              child: Container(
                width: 150,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)), child: Image.network(stadium.strStadiumThumb, fit: BoxFit.fill, width: double.infinity)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(stadium.strStadium, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, maxLines: 2,),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}

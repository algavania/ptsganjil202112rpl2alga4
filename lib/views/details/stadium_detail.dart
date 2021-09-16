import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:ptsganjil202112rpl2alga4/models/stadium_model.dart';

class StadiumDetail extends StatefulWidget {
  final StadiumModel stadium;

  const StadiumDetail({Key? key, required this.stadium}) : super(key: key);

  @override
  _StadiumDetailState createState() => _StadiumDetailState();
}

class _StadiumDetailState extends State<StadiumDetail> {

  Color color = Colors.white;

  Future<void> getImagePalette () async {
    ImageProvider imageProvider = NetworkImage(widget.stadium.strStadiumThumb);
    final PaletteGenerator paletteGenerator = await PaletteGenerator
        .fromImageProvider(imageProvider);
    setState(() {
      color = paletteGenerator.darkVibrantColor!.color;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImagePalette();
  }

  @override
  Widget build(BuildContext context) {
    final formatString = NumberFormat.currency(locale: 'id_ID', decimalDigits: 0, symbol: "");
    return Scaffold(
      appBar: AppBar(title: Text('Stadium Detail')),
      body: Container(
        color: color,
        child: Stack(children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.network(
                  widget.stadium.strStadiumThumb,
                  fit: BoxFit.fill,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  Expanded(child: Text('Stadium', style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text(widget.stadium.strStadium)),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.blue[50],
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text(widget.stadium.strStadiumLocation)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(child: Text('Team', style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text(widget.stadium.strTeam)),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.blue[50],
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(child: Text('Capacity', style: TextStyle(fontWeight: FontWeight.bold))),
                                  Expanded(child: Text(formatString.format(int.parse(widget.stadium.intStadiumCapacity)))),
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
                                  Text(widget.stadium.strStadiumDescription),
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
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

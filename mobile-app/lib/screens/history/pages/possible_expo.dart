import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slcovid_tracker/models/location.dart';
import 'package:intl/intl.dart';
import 'package:slcovid_tracker/states/exposed_bloc/exposed_bloc.dart';

class PossibleExpo extends StatefulWidget {
  @override
  _PossibleExpoState createState() => _PossibleExpoState();
}

class _PossibleExpoState extends State<PossibleExpo> {
   AssetImage lastimage;
  AssetImage train = AssetImage('asset/images/train.png');
  AssetImage car = AssetImage('asset/images/car.png');
  AssetImage bus = AssetImage('asset/images/bus.png');
  AssetImage locationimage = AssetImage('asset/images/location.png');
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<ExposedBloc>(context).exposedLocations,
      builder: _buildCheckedOut,
    );
  }

  Widget _buildCheckedOut(context, AsyncSnapshot<List<Location>> snapshot) {
    if (!snapshot.hasData) {
      return Container();
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        Location location = snapshot.data[index];
          switch (location.type) {
            case "sc_bus":
              lastimage = bus;
              break;
            case "sc_train":
              lastimage = train;
              break;
            case "sc_vehicle":
              lastimage = car;
              break;
            case "sc_location":
              lastimage = locationimage;
              break;
          }
        return Card(
          color: Theme.of(context).accentColor,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
                  maxRadius: 25,
                  backgroundColor: Colors.transparent,
                  backgroundImage: lastimage),
            title: Text(location.name, //data.name[index]
                style: TextStyle(color: Colors.black, fontSize: 16)),
            subtitle: Text(_genTimePeriod(location.checkIn, location.checkOut),
                //data.time[index]
                style: TextStyle(color: Colors.black54)),
          ),
        );
      },
    );
  }

  String _genTimePeriod(DateTime start, DateTime end) {
    String day = DateFormat('yyyy-MM-dd').format(start);
    String startTime = DateFormat('jm').format(start);
    String endTime = DateFormat('jm').format(start);

    return day + " from " + startTime + " to " + endTime;
  }
}

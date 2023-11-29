import 'package:flutter/material.dart';
import 'package:favplaces/models/place.dart';
import 'package:favplaces/screens/place_details.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.places});

  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return const Center(
          child: Text(
        "No Places added",
        style: TextStyle(color: Colors.white, fontSize: 19),
      ));
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: ((context, index) => ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(places[index].image),
            ),
            title: Text(
              places[index].title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) =>
                      PlaceDetailScreen(place: places[index])),
                ),
              );
            },
          )),
    );
  }
}

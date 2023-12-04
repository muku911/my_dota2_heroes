import 'package:flutter/material.dart';
import 'package:my_dota2_heroes/model/hero_data.dart';

class HeroesList extends StatelessWidget {
  const HeroesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(childCount: 124,
          (BuildContext context, int index) {
        return FutureBuilder<List<HeroData>>(
          future: loadHeroData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<HeroData>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              // Tampilkan data dari Future di dalam widget
              return InkWell(
                onTap: () {},
                child: Card(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child:
                            Image.asset("heroes/${snapshot.data![index].img}"),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                snapshot.data![index].localizedName,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      }),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_dota2_heroes/constant/my_constant_list.dart';
import 'package:my_dota2_heroes/extension/string_extension.dart';
import 'package:my_dota2_heroes/model/hero_data.dart';

class HeroesCarouselList extends StatelessWidget {
  final List<HeroData> heroes;

  const HeroesCarouselList({super.key, required this.heroes});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CarouselSlider.builder(
          options: CarouselOptions(
            height: 165,
            aspectRatio: 16 / 9,
            viewportFraction: 0.8,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: heroes.length,
          itemBuilder: (context, index, realIndex) {
            return Container(
              width: 375,
              height: 160,
              padding: const EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: const Color(0xFF2B5299),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1, color: Color(0xFF19376D)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        heroes[index].localizedName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage("heroes/${heroes[index].img}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Win Rate : ${(heroes[index].proWinRate * 100).toStringAsFixed(2)}%",
                                  style: heroAttributeTextStyle,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Attribute : ${heroes[index].primaryAttr.capitalize()}",
                                  style: heroAttributeTextStyle,
                                ),
                              ),
                              const SizedBox(height: 5),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  "Attack Type : ${heroes[index].attackType.capitalize()}",
                                  style: heroAttributeTextStyle,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}

class HeroesCarousel extends StatelessWidget {
  const HeroesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      expandedHeight: 185,
      flexibleSpace: FutureBuilder<List<HeroData>>(
        future: loadAndSortHeroData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<HeroData>? heroes = snapshot.data;
            return HeroesCarouselList(heroes: heroes!);
          }
        },
      ),
    );
  }
}

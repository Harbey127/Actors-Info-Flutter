import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/business_logic/cubit/characters_cubit.dart';
import '/constants/my_colors.dart';
import '/data/models/characters.dart';

class CharactersDetailsScreen extends StatelessWidget {
  final Character character;

  const CharactersDetailsScreen({required this.character, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getQuotes(character.currentName!);
    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        characterInfo(
                          'Job : ',
                          character.occupation!.join(' / '),
                        ),
                        buildDivider(285),
                        characterInfo(
                          'Appeared in : ',
                          character.category!,
                        ),
                        buildDivider(220),
                        characterInfo(
                          'Seasons : ',
                          character.appearance!.join(' / '),
                        ),
                        buildDivider(245),
                        characterInfo(
                          'Status : ',
                          character.status!,
                        ),
                        buildDivider(265),
                        character.betterCallSaulAppearance!.isEmpty ?
                        const SizedBox():
                        characterInfo(
                          'Better Call Saul Seasons : ',
                          character.betterCallSaulAppearance!.join(' / '),
                        ),
                        character.betterCallSaulAppearance!.isEmpty ?
                        const SizedBox():buildDivider(200),
                        characterInfo(
                          'Actor/Actress : ',
                          character.portrayed!,
                        ),
                        buildDivider(200),
                        BlocBuilder<CharactersCubit, CharactersState>(
                          builder:(context, state){
                            return checkQuotesAreLoaded(state);
                          },
                        ),
                        const SizedBox(height: 100,)
                      ],
                    ),
                  ),
                ],
              ),
          ),
        ],
      ),
    );
  }


  SliverAppBar buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.actorName!,
          style: const TextStyle(color: MyColors.white),
        ),
        background: Hero(
          tag: character.charId!,
          child: Image.network(
            character.img!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

 Divider buildDivider(double endIndent) {
    return Divider(
      color: MyColors.yellow,
      height: 30,
      thickness: 1,
      endIndent: endIndent,
    );
 }

  Widget checkQuotesAreLoaded(CharactersState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    }else{
      return  const Center(child: CircularProgressIndicator(color: MyColors.white,));
    }
  }
  Widget displayRandomQuoteOrEmptySpace( state){
    dynamic quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length -1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            color: MyColors.white,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: MyColors.yellow,
                offset: Offset(0, 0),
              )
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote),
            ],
          ),
        ),
      );
    }else{
      return const SizedBox();
    }
  }
}


import 'package:actors_info/constants/strings.dart';

import '/constants/my_colors.dart';
import '/data/models/characters.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: ()=> Navigator.pushNamed(context, charactersDetailsScreen, arguments: character),
        child: Hero(
          tag: character.charId!,
          child: GridTile(
            child: Container(
              color: MyColors.grey,
              child: character.img!.isNotEmpty?
               FadeInImage.assetNetwork(
                placeholder: 'assets/loading.gif',
                image: character.img!,
                 height: double.infinity,
                 width: double.infinity,
              ) : const CircularProgressIndicator(),
            ),
            footer: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
              color: Colors.black54,
              alignment: Alignment.bottomCenter,
              child: Text(
                '${character.currentName}',
                style: const TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.white,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

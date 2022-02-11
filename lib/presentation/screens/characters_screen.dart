import 'package:flutter_offline/flutter_offline.dart';

import '/business_logic/cubit/characters_cubit.dart';
import '/constants/my_colors.dart';
import '/data/models/characters.dart';
import '/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharactersScreen extends StatefulWidget {

  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<Character>? allCharacters;
  List<Character>? searchedForCharacter;
  final _searchTestController = TextEditingController();
  bool _isSearching = false;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: _isSearching ? _buildSearchedField() : const Text(
          'Characters',
          style: TextStyle(
            color: MyColors.white,
          ),
        ),
        backgroundColor: Colors.black,
        actions: _buildAppBarAction(),
        leading: _isSearching ? const BackButton(color: MyColors.grey,) : Container(),
      ),
      backgroundColor: MyColors.grey,
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
        ){
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return BlocBuilder<CharactersCubit, CharactersState>(
              builder: (context, state) {
                if (state is CharactersLoaded) {
                  allCharacters = (state).characters;
                  return buildListView();
                } else {
                  return const Center(child: CircularProgressIndicator(color: MyColors.white,),);
                }
              },
            );
          } else {
            return buildNoInternetWidget();
          }
        },
        child: buildNoInternetWidget(),
      ),
    );
  }
  Widget buildNoInternetWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          CircularProgressIndicator(color: MyColors.white,),
          SizedBox(height: 30,),
          Text(
            'There is no Internet.',
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchedField(){
    const textStyle = TextStyle(color: MyColors.grey, fontSize: 18);
    return TextField(
      controller: _searchTestController,
      cursorColor: MyColors.grey,
      decoration: const InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: textStyle,
      ),
      style: textStyle,
      onChanged: (searchedCharacter){
        addSearchedForItemsToSearchedList(searchedCharacter);
      },
    );
  }
  void addSearchedForItemsToSearchedList(String searchedCharacter){
    searchedForCharacter = allCharacters!.where((character) =>
        character.currentName!.toLowerCase().contains(searchedCharacter)
    ).toList();
    setState(() {});
  }

List<Widget> _buildAppBarAction(){
    if(_isSearching){
      return [
        IconButton(
          onPressed: (){
            _clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear, color: MyColors.white,),
        )
      ];
    }else{
      return [
        IconButton(
            onPressed: _startSearch,
            icon: const Icon(Icons.search, color: MyColors.white,),
        )
      ];
    }
}

 void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
 }
 void _stopSearching() {

   setState(() {
     _isSearching = false;
   });
}

 void _clearSearch(){
   setState(() {
     _searchTestController.clear();
   });
 }





  Widget buildListView() => SingleChildScrollView(
    child: Container(
      color: MyColors.grey,
      child: Column(
        children: [
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2/3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,

            ),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: _searchTestController.text.isEmpty ? allCharacters!.length : searchedForCharacter!.length,
            itemBuilder: (context, index){
              return  CharacterItem(
                character:  _searchTestController.text.isEmpty
                    ? allCharacters![index] : searchedForCharacter![index],
              );
            },
          ),
        ],
      ),
    ),
  );


}

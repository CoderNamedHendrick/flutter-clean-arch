import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

class HomePageWithBloc extends StatefulWidget {
  const HomePageWithBloc({Key key}) : super(key: key);

  @override
  _HomePageWithBlocState createState() => _HomePageWithBlocState();
}

class _HomePageWithBlocState extends State<HomePageWithBloc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RickAndMorty"),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: BlocConsumer<HomeCubit, HomeState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is Initial) {
                return _showLoadButton();
              } else if (state is Loading) {
                return CircularProgressIndicator();
              } else if (state is Error) {
                return Container();
              } else if (state is Success) {
                return _showCharactersList(state);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _showLoadButton() {
    return MaterialButton(
      onPressed: _loadData,
      child: Text("Load data"),
      color: Colors.blue,
    );
  }

  Widget _showCharactersList(Success state) {
    return ListView.builder(
      itemCount: state.characterList.length,
      itemBuilder: (context, index) {
        final character = state.characterList[index];
        return ListTile(
          leading: Image.network(
            character.image,
            errorBuilder: (context, error, stackTrace) => Text('😢\noffline'),
          ),
          title: Text('${character.name}'),
          subtitle: Text('${character.status}'),
        );
      },
    );
  }

  void _loadData() {
    final cubit = context.bloc<HomeCubit>();
    cubit.showLoadingAndFetchCharacters();
  }
}

/*
*  CUBIT: ViewCubit
*  Function: Change current view
*/

import 'package:bloc/bloc.dart';

class ViewCubit extends Cubit<int> {
  ViewCubit() : super( 0 );
  changePage( int page ){
    emit( page );
  }
}

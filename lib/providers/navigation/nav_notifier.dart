
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musicapp/providers/navigation/nav_state.dart';

class NavNotifier extends StateNotifier<NavStates>{
  NavNotifier(): super(const NavStates());

  void onIndexChanged(int index){
    state = state.copyWith(index: index);
  }
}

final navProvider = StateNotifierProvider<NavNotifier,NavStates>((ref)=> 
  NavNotifier());
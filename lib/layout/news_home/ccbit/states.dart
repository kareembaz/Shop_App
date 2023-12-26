abstract class newsStates {}

class newsInitialState extends newsStates {}

class newsButtonNavState extends newsStates {}

class newsGetBusinessSuccessState extends newsStates {}

class newsBusinessLoadingState extends newsStates {}

class newsGetBusinessErorrState extends newsStates {
  final String error;
  newsGetBusinessErorrState(this.error);
}

class newsGetSportsSuccessState extends newsStates {}

class newsSoprtsLoadingState extends newsStates {}

class newsGetSportsErorrState extends newsStates {
  final String error;
  newsGetSportsErorrState(this.error);
}

class newsGetScienceSuccessState extends newsStates {}

class newsScienceLoadingState extends newsStates {}

class newsGetScienceErorrState extends newsStates {
  final String error;
  newsGetScienceErorrState(this.error);
}

class SearchSuccessState extends newsStates {}

class SearchLoadingState extends newsStates {}

class SearchErorrState extends newsStates {
  final String error;
  SearchErorrState(this.error);
}

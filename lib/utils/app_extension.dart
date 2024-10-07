import 'package:book_app/pages/home_page.dart';

extension StatusExt on Status {
  String get displayName {
    switch (this) {
      case Status.fiction:
        return 'Fiction';
      case Status.animeManga:
        return 'Anime+Manga';
      case Status.actionAdventure:
        return 'Action+Adventure';
      case Status.novel:
        return 'Novel';
      case Status.horror:
        return 'Horror';
      default:
        return '';
    }
  }
  String get tabLabel {
    switch (this) {
      case Status.fiction:
        return 'Fiction';
      case Status.animeManga:
        return 'Anime';
      case Status.actionAdventure:
        return 'Adventure';
      case Status.novel:
        return 'Novel';
      case Status.horror:
        return 'Horror';
    }
  }
}


extension IntExt on int? {
  String get toVND{
    String st = ((this ?? 0) * 24000).toString();
    String st2 = "";
    int d = 0 ;
    for(int i = st.length - 1 ; i >= 0 ; i--){
      st2 = "${st[i]}$st2";
      d++;
      if((d == 3) && (i != 0)){
        st2 = ".$st2";
        d = 0;
      }
    }
    return "$st2 VNĐ";
  }
}
enum RouteName { Menu, Reservation, Information, Cart, Profile, Undefined, }

class AppConfig {
  static get menuPage => RouteName.Menu;
  static get resvPage => RouteName.Reservation;
  static get infoPage => RouteName.Information;
  static get cartPage => RouteName.Cart;
  static get profPage => RouteName.Profile;
  static get undefinedPage => RouteName.Undefined;

  static get defaultFontFamily => "Nunito Sans";
}
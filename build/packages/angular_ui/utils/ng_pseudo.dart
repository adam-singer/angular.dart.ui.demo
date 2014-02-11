// Copyright (C) 2013 - 2014 Angular Dart UI authors. Please see AUTHORS.md.
// https://github.com/akserg/angular.dart.ui
// All rights reserved.  Please see the LICENSE.md file.
part of angular.ui.utils;

@NgDirective(
    selector: '[ng-pseudo]',
    map: const { 'ng-pseudo': '@name' }
)
class NgPseudo {
  dom.Element _element;
  set name(n) {
    _element.pseudo = n;
  }

  NgPseudo(dom.Element this._element);
}
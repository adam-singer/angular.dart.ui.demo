// Copyright (C) 2013 - 2014 Angular Dart UI authors. Please see AUTHORS.md.
// https://github.com/akserg/angular.dart.ui
// All rights reserved.  Please see the LICENSE.md file.
library angular.ui.position;

import 'dart:html' as dom;
import "package:angular/angular.dart";

/**
 * Position Module
 */
class PositionModule extends Module {
  PositionModule() {
//    factory(Position, (Injector injector) {
//      return new Position(dom.document, dom.window);
//    });
    type(Position);
  }
}


/**
 * A set of utility methods that can be use to retrieve position of DOM elements.
 * It is meant to be used where we need to absolute-position DOM elements in
 * relation to other, existing elements (this is the case for tooltips, popovers,
 * typeahead suggestions etc.).
 */
class Position {

//  dom.Document document;
//  dom.Window window;
  
//  Position(this.document, this.window);
  Position();
  
  dynamic _getStyle(dom.Element el, String cssprop) {
//    if (el.currentStyle) { //IE
//      return el.currentStyle[cssprop];
//    } else if ($window.getComputedStyle) {
//      return $window.getComputedStyle(el)[cssprop];
//    }
//    // finally try and get inline style
//    return el.style[cssprop];
    return el.style.getPropertyValue(cssprop);
  }
  
  /**
   * Checks if a given element is statically positioned
   * @param element - raw DOM element
   */
  bool _isStaticPositioned(dom.Element element) {
//    return (_getStyle(element, "position") || 'static' ) === 'static';
    String pos = _getStyle(element, "position");
    return pos != null && pos == 'static';
  }
  
  /**
   * returns the closest, non-statically positioned parentOffset of a given element
   * @param element
   */
  dynamic _parentOffsetEl(dom.Element element) {
//    var docDomEl = $document[0];
//    var offsetParent = element.offsetParent || docDomEl;
//    while (offsetParent && offsetParent !== docDomEl && _isStaticPositioned(offsetParent) ) {
//      offsetParent = offsetParent.offsetParent;
//    }
//    return offsetParent || docDomEl;
    var docDomEl = dom.document;
    var offsetParent = element.offsetParent != null ? element.offsetParent : docDomEl;
    while (offsetParent != null && offsetParent != docDomEl && _isStaticPositioned(offsetParent) ) {
      offsetParent = offsetParent.offsetParent;
    }
    return offsetParent == null ? docDomEl : offsetParent;
  }
  
  /**
   * Provides read-only equivalent of jQuery's position function:
   * http://api.jquery.com/position/
   */
  dynamic position(dom.Element element) {
//    var elBCR = offset(element);
//    var offsetParentBCR = { top: 0, left: 0 };
//    var offsetParentEl = parentOffsetEl(element[0]);
//    if (offsetParentEl != $document[0]) {
//      offsetParentBCR = this.offset(angular.element(offsetParentEl));
//      offsetParentBCR.top += offsetParentEl.clientTop - offsetParentEl.scrollTop;
//      offsetParentBCR.left += offsetParentEl.clientLeft - offsetParentEl.scrollLeft;
//    }
//
//    var boundingClientRect = element[0].getBoundingClientRect();
//    return {
//      width: boundingClientRect.width || element.prop('offsetWidth'),
//      height: boundingClientRect.height || element.prop('offsetHeight'),
//      top: elBCR.top - offsetParentBCR.top,
//      left: elBCR.left - offsetParentBCR.left
//    };
    var elBCR = offset(element);
    var offsetParentBCR = new Rect();
    var offsetParentEl = _parentOffsetEl(element);
    if (offsetParentEl != dom.document) {
      offsetParentBCR = offset(offsetParentEl);
      offsetParentBCR.top += offsetParentEl.clientTop - offsetParentEl.scrollTop;
      offsetParentBCR.left += offsetParentEl.clientLeft - offsetParentEl.scrollLeft;
    }
    
    var boundingClientRect = element.getBoundingClientRect();
    return new Rect(
        width: boundingClientRect.width != null ? boundingClientRect.width : element.offsetWidth,
        height: boundingClientRect.height != null ? boundingClientRect.height : element.offsetHeight,
        top: elBCR.top - offsetParentBCR.top,
        left: elBCR.left - offsetParentBCR.left);
  }
  
  /**
   * Provides read-only equivalent of jQuery's offset function:
   * http://api.jquery.com/offset/
   */
  Rect offset(dom.Element element) {
//    var boundingClientRect = element[0].getBoundingClientRect();
//    return {
//      width: boundingClientRect.width || element.prop('offsetWidth'),
//      height: boundingClientRect.height || element.prop('offsetHeight'),
//      top: boundingClientRect.top + ($window.pageYOffset || $document[0].body.scrollTop || $document[0].documentElement.scrollTop),
//      left: boundingClientRect.left + ($window.pageXOffset || $document[0].body.scrollLeft  || $document[0].documentElement.scrollLeft)
//    };
    var boundingClientRect = element.getBoundingClientRect();
    var offs = new Rect(
      width: boundingClientRect.width != null ? boundingClientRect.width : element.offsetWidth,
      height : boundingClientRect.height != null ? boundingClientRect.height : element.offsetHeight,
      top : boundingClientRect.top + (dom.window.pageYOffset != null ? dom.window.pageYOffset : dom.document.body.scrollTop != null ? dom.document.body.scrollTop : dom.document.documentElement.scrollTop),
      left : boundingClientRect.left + (dom.window.pageXOffset != null ? dom.window.pageXOffset : dom.document.body.scrollLeft != null ? dom.document.body.scrollLeft : dom.document.documentElement.scrollLeft));
    return offs;
  }
}

/**
 * A class for representing two-dimensional rectangles.
 */
class Rect {
  var left, top, width, height;
  
  Rect({this.left:0, this.top:0, this.width:0, this.height:0});
}
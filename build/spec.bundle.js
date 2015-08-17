/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};

/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {

/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;

/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};

/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);

/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;

/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}


/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;

/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;

/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";

/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	__webpack_require__(1);


/***/ },
/* 1 */
/***/ function(module, exports, __webpack_require__) {

	var Document;

	Document = __webpack_require__(2);

	describe("Document", function() {
	  return describe("@create_fake", function() {
	    return it("creates an HTML element with no contents", function() {
	      var subject;
	      subject = Document.create_fake();
	      return expect(subject.dom.innerHTML).toEqual("");
	    });
	  });
	});


/***/ },
/* 2 */
/***/ function(module, exports) {

	var DOMElement, DOMFactory, Document;

	DOMElement = (function() {
	  function DOMElement(factory1, name1, contents) {
	    this.factory = factory1;
	    this.name = name1;
	    this.contents = contents;
	  }

	  DOMElement.prototype.render = function() {
	    return this.factory.createElement(this.name);
	  };

	  return DOMElement;

	})();

	DOMFactory = (function() {
	  function DOMFactory(document1) {
	    this.document = document1;
	    if (this.document == null) {
	      this.document = document;
	    }
	  }

	  DOMFactory.prototype.createElement = function(name) {
	    return this.document.createElement(name);
	  };

	  DOMFactory.prototype.html = function(fn) {
	    return new DOMElement(this, this.name, null);
	  };

	  return DOMFactory;

	})();

	module.exports = Document = (function() {
	  function Document(document1, dom1) {
	    this.document = document1;
	    this.dom = dom1;
	    if (this.document == null) {
	      this.document = document;
	    }
	    this.factory = new DOMFactory(this.document);
	    if (this.dom == null) {
	      this.dom = this.document.documentElement;
	    }
	  }

	  Document.create_fake = function(document) {
	    var dom, factory;
	    factory = new DOMFactory(document);
	    dom = factory.html(function() {}).render();
	    return new Document(document, dom);
	  };

	  return Document;

	})();


/***/ }
/******/ ]);
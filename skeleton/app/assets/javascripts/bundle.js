/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId])
/******/ 			return installedModules[moduleId].exports;
/******/
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			exports: {},
/******/ 			id: moduleId,
/******/ 			loaded: false
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.loaded = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	const UsersSearch = __webpack_require__(2);
	const TweetCompose = __webpack_require__(3);
	
	$(() => {
	  $('.follow-toggle').each((_, el) => {
	    new FollowToggle(el);
	  });
	  $('.users-search').each((_, el) => {
	    new UsersSearch(el);
	  });
	  $('.tweet-compose').each((_, el) => {
	    new TweetCompose(el);
	  });
	});


/***/ },
/* 1 */
/***/ function(module, exports) {

	function FollowToggle (el, options) {
	  this.$el = $(el);
	  this.userId = this.$el.data("user-id") || options.userId;
	  this.followState = (this.$el.data("initial-follow-state") ||
	                        options.followState);
	  this.$el.on("click", this.handleClick.bind(this));
	  this.render();
	}
	
	FollowToggle.prototype.render = function () {
	  if (this.followState === "unfollowing") {
	    this.$el.text("Unfollowing");
	  } else if (this.followState === "following") {
	    this.$el.text("Following");
	  } else if (this.followState === "followed") {
	    this.$el.text("Unfollow");
	  } else {
	    this.$el.text("Follow");
	  }
	};
	
	FollowToggle.prototype.toggleFollowState = function () {
	  if (this.followState === "following" ) {
	    this.followState = "followed";
	  } else {
	    this.followState = "unfollowed";
	  }
	};
	
	FollowToggle.prototype.handleClick = function (event) {
	  event.preventDefault();
	  let submitData = $(event.currentTarget).serialize();
	  let method;
	  if (this.followState === "unfollowed") {
	    method = "POST";
	    this.followState = "following";
	  } else {
	    method = "DELETE";
	    this.followState = "unfollowing";
	  }
	  this.$el.prop("disabled", true);
	  this.render();
	  $.ajax({
	    dataType: "JSON",
	    method: method,
	    url: `/users/${this.userId}/follow`,
	    data: submitData,
	    success: function () {
	      this.toggleFollowState();
	      this.$el.prop("disabled", false);
	      this.render();
	    }.bind(this)
	  });
	};
	
	
	
	module.exports = FollowToggle;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const FollowToggle = __webpack_require__(1);
	
	class UsersSearch {
	  constructor(el) {
	    this.$el = $(el);
	    this.$input = this.$el.find("input");
	    this.$ul = this.$el.find("ul");
	    let that = this;
	    this.$el.find('.submit').on('click', this.handleInput.bind(that));
	  }
	
	  handleInput(event) {
	    event.preventDefault();
	    let data = this.$input.serialize();
	    $.ajax({
	      method: 'GET',
	      url: '/users/search',
	      dataType: 'json',
	      data: data,
	      success: function(users) {
	        this.renderResults(users);
	      }.bind(this)
	    });
	  }
	
	  renderResults (users) {
	    this.$ul.each((_, oldUser) => {
	      $(oldUser).text("");
	    });
	    $(users).each((_, newUser) => {
	      let $link = $("<li></li>");
	      let $alink = $(`<a href='/users/${newUser.id}'></a>`);
	      let $button = $('<button></button>');
	      let follow = newUser.followed ? "followed" : "unfollowed";
	      new FollowToggle($button, {"userId": `${newUser.id}`, "followState": `${follow}`});
	      $alink.text(newUser.username);
	      $link.append($alink);
	      this.$ul.append($link).append($button);
	    });
	  }
	}
	
	module.exports = UsersSearch;


/***/ },
/* 3 */
/***/ function(module, exports) {

	class TweetCompose {
	  constructor(el) {
	    this.$el = $(el);
	    let that = this;
	    this.$el.find('.submit').on('click', this.submit.bind(that));
	  }
	
	  clearInput() {
	    this.$el.find("input").text("");
	  }
	
	  handleSuccess() {
	    
	  }
	
	  submit(event) {
	    event.preventDefault();
	    let data = this.$el.serializeJSON();
	    this.$el.find("input").prop("disabled", true);
	    // this.render();
	    $.ajax ({
	      url: "/tweets",
	      method: "POST",
	      dataType: "JSON",
	      data: data,
	      success: function(tweet) {
	        this.$el.find("input").prop("disabled", false);
	        this.clearInput();
	        this.handleSuccess(tweet);
	
	      }.bind(this)
	    });
	  }
	
	
	}
	
	module.exports = TweetCompose;


/***/ }
/******/ ]);
//# sourceMappingURL=bundle.js.map
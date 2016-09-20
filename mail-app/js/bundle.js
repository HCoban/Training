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

	const Router = __webpack_require__(1);
	const Inbox = __webpack_require__(2);
	const Sent = __webpack_require__(4);

	window.addEventListener("DOMContentLoaded", () => {
	  let sidebar = Array.from(window.document.querySelectorAll(".sidebar-nav li"));
	  window.location.hash = "inbox";
	  sidebar.forEach( (el) => {
	    el.addEventListener("click", (event) => {
	      event.preventDefault();
	      let place = el.innerText.toLowerCase();
	      window.location.hash = place;
	    });
	  });

	  let newNode = document.querySelectorAll('.content')[0];

	  (new Router(newNode, routes)).start();
	});

	let routes = {inbox: Inbox, sent: Sent};


/***/ },
/* 1 */
/***/ function(module, exports) {

	class Router {
	  constructor (node, routes) {
	    this.node = node;
	    this.routes = routes;
	  }

	  start () {
	    this.render();
	    window.addEventListener("hashchange", (event) => {
	      event.preventDefault();
	      this.render();
	    });
	  }

	  activeRoute() {
	    return this.routes[window.location.hash.slice(1)];
	  }

	  render () {
	    this.node.innerHTML = "";
	    let component = this.activeRoute();
	    if (component !== undefined) {
	      let pEl = document.createElement("p");
	      this.node.appendChild(component.render());
	    }
	  }
	}

	module.exports = Router;


/***/ },
/* 2 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

	let Inbox = {};


	Inbox.render = () => {
	  let el = document.createElement("ul");
	  el.className = "messages";
	  const mess = MessageStore.getInboxMessages();
	  mess.forEach( (element) => {
	    el.appendChild(Inbox.renderMessage(element));
	  });
	  return el;
	};

	Inbox.renderMessage = (element) => {
	  let ret = document.createElement("li");
	  ret.className = "message";
	  ret.innerHTML = `<span class="from">${element.from}</span>
	  <span class="subject">${element.subject}</span>
	  <span class="body">${element.body}</span>`;

	  return ret;
	};


	module.exports = Inbox;


/***/ },
/* 3 */
/***/ function(module, exports) {

	let messages = {
	  sent: [
	    {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
	    {to: "person@mail.com", subject: "zzz", body: "so booring"}
	  ],
	  inbox: [
	    {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body:
	"Stay at home mom discovers cure for leg cramps. Doctors hate her"},
	  {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"}
	]
	};

	let MessageStore = {
	  getInboxMessages: () => {
	    return messages.inbox;
	  },
	  getSentMessages: () => {
	    return messages.sent;
	  }
	};

	module.exports = MessageStore;


/***/ },
/* 4 */
/***/ function(module, exports, __webpack_require__) {

	const MessageStore = __webpack_require__(3);

	let Sent = {};


	Sent.render = () => {
	  let el = document.createElement("ul");
	  el.className = "messages";
	  const mess = MessageStore.getSentMessages();
	  mess.forEach( (element) => {
	    el.appendChild(Sent.renderMessage(element));
	  });
	  return el;
	};

	Sent.renderMessage = (element) => {
	  let ret = document.createElement("li");
	  ret.className = "message";
	  ret.innerHTML = `<span class="to">${element.to}</span>
	  <span class="subject">${element.subject}</span>
	  <span class="body">${element.body}</span>`;

	  return ret;
	};


	module.exports = Sent;


/***/ }
/******/ ]);
const Router = require('./router.js');
const Inbox = require('./inbox.js');
const Sent = require('./sent.js');

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

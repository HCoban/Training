const MessageStore = require('./message_store.js');

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

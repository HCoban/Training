const MessageStore = require('./message_store.js');

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

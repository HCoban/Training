const FollowToggle = require('./follow_toggle.js');

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

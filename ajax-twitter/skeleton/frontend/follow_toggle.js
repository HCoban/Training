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

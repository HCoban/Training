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

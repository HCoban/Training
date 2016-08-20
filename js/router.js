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

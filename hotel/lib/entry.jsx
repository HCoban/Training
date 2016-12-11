import configureStore from './store/store';
import Hotel from './components/hotel';
import React from 'react';
import ReactDOM from 'react-dom';

document.addEventListener("DOMContentLoaded", () => {
  let store = configureStore;
  const root = document.getElementById("root");

  ReactDOM.render(<Hotel store={store} />, root);
});

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application.scss";
import "../stylesheets/custom.scss";


import "../javascripts/crop-image";

// GET users/:id/account/edit
import { cropperAvatar } from "../javascripts/crop-image";
global.cropperAvatar = cropperAvatar

// GET users/:id/account/edit, users/:id/show
import { modalOpen, modalClose, fade } from "../javascripts/display-img";
global.modalOpen = modalOpen
global.modalClose = modalClose
global.fade = fade
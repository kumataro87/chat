import Cropper from 'cropperjs'

function selectRange(obj) {
  const image = document.getElementById('change-image');
  const cropper = new Cropper(image, {
    aspectRatio: 1 / 1,
    viewMode: 3,
    crop(e) {
      document.getElementById("user_image_x").value = e.detail.x;
      document.getElementById("user_image_y").value = e.detail.y;
      document.getElementById("user_image_w").value = e.detail.width;
      document.getElementById("user_image_h").value = e.detail.height;
    }
  });
  document.getElementById('modal-cut').addEventListener('click', function () {
    const resultImgUrl = cropper.getCroppedCanvas().toDataURL();
    const result = document.getElementById('avatar-image');
    result.width  = 50;
    result.height = 50;
    result.src = resultImgUrl;
    cropper.destroy()
    modalClose()
  });
  document.getElementById('modal-close').addEventListener('click', function(){
    obj.value = ""
    cropper.destroy()
    modalClose()
  })
}

export function insertImage(obj) {
    var fileReader = new FileReader();
    fileReader.onload = (function() {
      document.getElementById('change-image').src = fileReader.result;
    });
    fileReader.readAsDataURL(obj.files[0]);
}

export function cropperAvatar(obj){
  const img = document.getElementById("change-image")
  modalOpen()
  insertImage(obj)
  img.addEventListener('load', () => {
    selectRange(obj)
  })
}

function modalOpen() {
    const modal = document.getElementById('modal')
    modal.style.opacity = 1
    modal.style.zIndex  = 1
}

function modalClose() {
  const modal = document.getElementById('modal')
  imgReset
  modal.style.opacity = 0
  modal.style.zIndex = -1
}

function imgReset() {
  const img = document.getElementById("change-image")
  img.src = ''
}
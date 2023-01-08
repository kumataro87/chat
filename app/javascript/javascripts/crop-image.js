import Cropper from 'cropperjs'

function selectRange(obj) {
  const image = document.getElementById('change-image');
  const post_btn = document.getElementById('post-btn')
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
  document.getElementById('modal-cut').addEventListener('click', function() {
    const resultImgUrl = cropper.getCroppedCanvas().toDataURL();
    const result = document.getElementById('avatar-image');
    result.width  = 90;
    result.height = 90;
    result.src = resultImgUrl;
    cropper.destroy()
    modalClose()
    post_btn.click();
  });
  document.getElementById('modal-close').addEventListener('click', function(){
    // getCroppedCanvas()を実行しない場合、再度画像を変更する際に以前読み込んだ画像が表示される
    cropper.getCroppedCanvas().toDataURL();
    cropper.destroy()
    obj.value = ""
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
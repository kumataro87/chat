export function modalOpen() {
  const modal = document.getElementById('modal')
  modal.classList.add('show');
  modal.style.opacity = 1
  modal.style.zIndex  = 1
}

export function fade() {
  var target = document.getElementById("fadeLayer");
  if(target.style.visibility == "visible"){
    target.style.visibility = "hidden";  
  } else {
    target.style.visibility = "visible";
  }
}

export function modalClose() {
  const modal = document.getElementById('modal')
  modal.classList.remove('show');
  modal.style.opacity = 0
  modal.style.zIndex = -1
}
export function modalOpen() {
  const modal = document.getElementById('modal')
  modal.classList.add('show');
  modal.style.opacity = 1
  modal.style.zIndex  = 1
}

export function modalClose() {
  const modal = document.getElementById('modal')
  modal.classList.remove('show');
  modal.style.opacity = 0
  modal.style.zIndex = -1
}
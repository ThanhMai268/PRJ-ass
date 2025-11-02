// ===== CHUYỂN GIỮA SIGNIN / SIGNUP =====
const signUpButton = document.getElementById('signUp');
const signInButton = document.getElementById('signIn');
const container = document.getElementById('container');

if (signUpButton && signInButton && container) {
  signUpButton.addEventListener('click', () => {
    container.classList.add("right-panel-active");
  });

  signInButton.addEventListener('click', () => {
    container.classList.remove("right-panel-active");
  });
}

// ===== TOAST THÔNG BÁO THÀNH CÔNG =====
document.addEventListener('DOMContentLoaded', function () {
  const toast = document.getElementById('toast');
  if (toast) {
    // Hiện thanh thông báo
    toast.classList.add('show');

    // Tự ẩn sau 3 giây
    setTimeout(() => {
      toast.classList.remove('show');
    }, 3000);
  }
});

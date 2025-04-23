const gBASE_URL = "http://160.191.89.57:8080/icafe";

//Xử lý object trả về khi login thành công
function responseHandler(data) {
  //Lưu token vào cookie trong 1 ngày
  setCookie("token", data, 1);
  setTimeout(function () {
    // Navigate to index.html
    navigateToCorrectPage();
  }, 1000);
}

//Hàm setCookie đã giới thiệu ở bài trước
function setCookie(cname, cvalue, exdays) {
  var d = new Date();
  d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
  var expires = "expires=" + d.toUTCString();
  document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
}

//Hàm get Cookie đã giới thiệu ở bài trước
function getCookie(cname) {
  var name = cname + "=";
  var decodedCookie = decodeURIComponent(document.cookie);
  var ca = decodedCookie.split(';');
  for (var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

function getUserRoleFromToken(token) {
  try {
    const payload = JSON.parse(atob(token.split('.')[1]));
    return payload.user.role || "CLIENT"; // fallback là USER nếu không có role
  } catch (e) {
    console.error("Không lấy được role từ token:", e);
    return "CLIENT";
  }
}

function isTokenValid(token) {
  try {
    const payload = JSON.parse(atob(token.split('.')[1]));
    const now = Math.floor(Date.now() / 1000);
    return payload.exp && payload.exp > now;
  } catch (e) {
    console.error("Token không hợp lệ:", e);
    return false;
  }
}

function validatePassword(password) {
  const minLength = /.{8,}/;
  const hasLowerCase = /[a-z]/;
  const hasUpperCase = /[A-Z]/;
  const hasNumber = /[0-9]/;

  if (!minLength.test(password)) {
    return "Mật khẩu phải có ít nhất 8 ký tự.";
  }
  if (!hasLowerCase.test(password)) {
    return "Mật khẩu phải có ít nhất một chữ thường.";
  }
  if (!hasUpperCase.test(password)) {
    return "Mật khẩu phải có ít nhất một chữ in hoa.";
  }
  if (!hasNumber.test(password)) {
    return "Mật khẩu phải có ít nhất một chữ số.";
  }

  return ""; // ✅ Trả về chuỗi rỗng nếu hợp lệ
}

function deleteCookie(name) {
  document.cookie = name + '=; Path=/; Expires=Thu, 01 Jan 1970 00:00:01 GMT;';
}

function showToast(message, type) {
  // Lấy phần tử Toast và toast-content
  var toastEl = document.getElementById('myToast');
  var toastContent = toastEl.querySelector('#toast-content');
  var iconToast = toastEl.querySelector('.icon-toast i');
  var zoneIcon = toastEl.querySelector('.icon-toast');

  // Cập nhật nội dung thông báo
  if (toastContent) {
    toastContent.textContent = message;
  }

  // Xóa các lớp màu và icon cũ
  zoneIcon.classList.remove('bg-success', 'bg-danger', 'bg-warning', 'bg-info');
  if (iconToast) {
    iconToast.classList.remove('bi-check-lg', 'bi-exclamation-triangle', 'bi-info-circle');
  }

  // Cập nhật màu nền và icon dựa trên type
  if (type === "success") {
    if (iconToast) {
      iconToast.classList.add('bi-check-lg'); // Icon check cho success
    }
  } else if (type === "error") {
    zoneIcon.classList.add('bg-danger');
    if (iconToast) {
      iconToast.classList.add('bi-x-circle'); // Icon lỗi cho error
    }
  } else if (type === "warning") {
    zoneIcon.classList.add('bg-warning');
    if (iconToast) {
      iconToast.classList.add('bi-exclamation-triangle'); // Icon cảnh báo cho warning
    }
  } else {
    zoneIcon.classList.add('bg-info');
    if (iconToast) {
      iconToast.classList.add('bi-info-circle'); // Icon thông tin cho info
    }
  }

  // Khởi tạo và hiển thị Toast
  var toast = new bootstrap.Toast(toastEl);
  toast.show();
}

function navigateToCorrectPage() {
  const token = getCookie("token"); // hoặc lấy từ localStorage nếu bạn dùng cái đó
  if (token && isTokenValid(token)) {
    const role = getUserRoleFromToken(token);


    switch (role) {
      case "ADMIN":
        window.location.href = "report";
        break;
      case "STAFF":
        window.location.href = "order";
        break;
      case "MANAGER":
        window.location.href = "report";
        break;
      default:
        alert("Không xác định được quyền người dùng!");
        window.location.href = "login";
    }
  }
}
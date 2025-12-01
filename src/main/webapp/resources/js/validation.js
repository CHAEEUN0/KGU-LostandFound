function CheckRegister() {

    var nickname = document.getElementById("nickname");
    var id = document.getElementById("id");
    var password = document.getElementById("password");
    var checkPassword = document.getElementById("checkPassword");

    // 닉네임 체크
    if (nickname.value.trim() == "") {
        alert("닉네임을 입력하세요.");
        nickname.focus();
        return false;
    }

    // 학번 숫자 확인
    if (isNaN(id.value)) {
        alert("[학번] 숫자만 입력하세요.");
        id.focus();
        return false;
    }

    // 학번 자리수 확인
    if (id.value.length != 9) {
        alert("학번은 9자리입니다.");
        id.focus();
        return false;
    }

    // 비밀번호 일치 확인
    if (password.value != checkPassword.value) {
        alert("비밀번호가 일치하지 않습니다.");
        checkPassword.focus();
        return false;
    }

    // 모든 체크 통과 → submit 진행
    return true;  // 이걸 해야 form 제출됨
}

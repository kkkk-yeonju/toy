<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="login_form_inner register_form_inner">
				<h3>회원가입</h3>
				<form class="row" action="register" id="register_form" method="post">
					<div class="col-md-12 form-group">
						<label for="id">아이디</label>
						<input type="text" class="form-control" id="id" name="id" placeholder="ID" onfocus="this.placeholder = ''" onblur="this.placeholder = 'ID'">
					</div>
					<div class="col-md-12 form-group">
						<label for="pwd">비밀번호</label>
						<input type="password" class="form-control" id="pwd" name="pwd" placeholder="password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'password'">
            				</div>
            				<div class="col-md-12 form-group">
            					<label for="name">이름</label>
						<input type="text" class="form-control" id="name" name="name" placeholder="name" onfocus="this.placeholder = ''" onblur="this.placeholder = 'name'">
            				</div>
					
					<div class="col-md-12 form-group">
						<div class="creat_account">
							<input type="checkbox" id="f-option2" name="selector">
							<label for="f-option2">Keep me logged in</label>
						</div>
					</div>
					<div class="col-md-12 form-group">
						<button class="btn btn-dark" type="submit" id="submit">Register</button>
						<button class="btn btn-danger" id="cancel">Cancel</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>

<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 취소
	$("#cancel").on("click", function(){
		
		location.href = "/";
				    
	})

	$("#submit").on("click", function(){
		if($("#id").val()==""){
			alert("아이디를 입력해주세요.");
			$("#id").focus();
			return false;
		}
		if($("#pwd").val()==""){
			alert("비밀번호를 입력해주세요.");
			$("#pwd").focus();
			return false;
		}
		if($("#name").val()==""){
			alert("이름을 입력해주세요.");
			$("#name").focus();
			return false;
		}

		alert($("#name").val()+"님 회원가입을 축하합니다!");
	});
	
		
	
})
</script>
</body>
</html>
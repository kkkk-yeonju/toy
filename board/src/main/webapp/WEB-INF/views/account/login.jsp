<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

<style type="text/css">
.login_form {
	width: 100%;
    max-width: 330px;
    padding: 15px;
    margin: auto;
}
</style>

</head>
<body>
<div class="container">
	<div class="row">
		<div class="col">
			<div class="login_form_inner">
				<form class="row login_form" action="login" id="contactForm" method="post">
					<h3>Log in</h3>
					<div class="col-md-12 form-group">
						<input type="text" class="form-control" id="id" name="id" placeholder="ID" onfocus="this.placeholder = ''" onblur="this.placeholder = 'ID'">
					</div>
					<div class="col-md-12 form-group">
						<input type="password" class="form-control" id="pwd" name="pwd" placeholder="Password" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password'">
					</div>
					<div class="col-md-12 form-group">
						<div class="creat_account">
							<input type="checkbox" id="f-option2" name="selector">
							<label for="f-option2">Keep me logged in</label>
						</div>
					</div>
					<div class="col-md-12 form-group">
						<button type="submit" class="btn btn-dark btn-lg btn-block">Log In</button>
					</div>
					<div>
						<a href="#">Forgot Password?</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
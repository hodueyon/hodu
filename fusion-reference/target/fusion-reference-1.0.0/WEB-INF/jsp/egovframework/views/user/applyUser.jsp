<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"></head>
<style>
	label{
		font-weight : bold;
	}
	
</style>
</head>
<body>
	<div class="rounded d-flex justify-content-center align-items-center w-200">
	    <form action="/user/applyUser.do" method="post" id="inputFrm">
			<h1>회원가입</h1>
			 <div class="mb-3" id="idinputDiv">
		          <label for="user_name" class="form-label">아이디</label>
		          <br>
		          <p>5자에서 10자이내의 길이로, 숫자와 영어를 꼭 포함해 주세요 !</p>
		          <div class = "mb-3" id="idDiv">
			          <input type="text" class="form-control idInput"  id="user_name" name="user_name"  minlength="5" maxlength="10" required>
			          <button type="button" class="btn btn-primary"  id="checkId" style="width : 100px">중복확인</button>
					<div class="valid-feedback">
				            아이디 중복 체크 해주세요!
			          </div>
				      <div class="invalid-feedback">
			             영어와 숫자를 포함하고, 5자 이상인지 확인해 주세요!
				      </div>
		          </div>
		        <input type="hidden" value="false" id="IdLastCK">
		       </div>
		       <div class="mb-3">
		            <label for="password" class="form-label">비밀번호</label>
		            <p>8자에서 12자 사이 길이로, 영어, 숫자, 특수문자를 포함해 주세요!</p>
		            <input type="password" id="password" name="password" class="passwdInput form-control"  minlength="8" maxlength="12" required>
		            <div class="valid-feedback">
		              사용 가능한 비밀번호 입니다!
		            </div>
		            <div class="invalid-feedback">
		              영어, 숫자, 특수문자 포함 8자 이상으로 작성해 주세요!
		            </div>
		          </div>
		        <div class="mb-3">
		          <label for="passwdInputCk" class="form-label">비밀번호 체크</label>
		          <input type="password" class="form-control" id="passwdInputCk"  minlength="8" maxlength="12" required>
		          <div class="valid-feedback">
		            비밀번호가 일치합니다
		          </div>
		          <div class="invalid-feedback">
		            비밀번호가 일치하지 않습니다. 다시 확인해 주세요!
		          </div>
		        </div>
		        <div class="mb-3">
		           <label for="name" class="form-label">성함</label>
		          <input type="text" class="form-control" id="real_name" name="real_name" minlength="1" maxlength="10" required>
		        </div>
		        <div class=" d-flex justify-content-center align-items-center">
			        <button type="submit" class="btn btn-primary m-1">가입하기</button>
			        <button type="button" class="btn btn-primary m-1" onclick="location.href='/user/loginfrm.do'">로그인</button>
			        <button type="button" class="btn btn-primary m-1" onclick="location.href='/board/boardList.do'">게시판</button>
		        </div>
	      </form>
	    </div>
	<script>
	window.onload = function() {
		 $("#checkId").attr("disabled", true);
	};

	   var isIDValid=false;
	   var isPasswdValid=false;
	   var isPasswdReCk = false;
	   var IdLastCK = false;
	   
	   function patternID(id){
		   var pattern =  /^(?=.*?[a-z])(?=.*?[0-9]).{5,10}$/;
		   return pattern.test(id);
	   }
	   
	   function patternPasswd(password){
			var pattern =   /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,12}$/;
			
			return pattern.test(password);
	   }
	   
		//아이디 작성되거나 , 값이 변했을때
		$('#user_name').on("change", function(){

			isIDValid = false;
			IdLastCK = false;
			
			this.classList.remove("is-valid");
			this.classList.remove("is-invalid");
			
			$('#idinputDiv').find('div.valid-feedback').text("아이디 중복 체크 해주세요!");
			
			
			console.log("중복체크"+IdLastCK);
			console.log("적당한지"+isIDValid);
			
			
			$("#checkId").attr("disabled", true);
			$('#idinputDiv').find('find.valid-feedback').text("아이디 중복 체크 해주세요!");
			let id = this.value;
			isIDValid = patternID(id);
			if(isIDValid){
				this.classList.remove("is-invalid");
		        this.classList.add("is-valid");
		        
		        $('#checkId').removeAttr("disabled");
			}else{
				 this.classList.remove("is-valid");
		         this.classList.add("is-invalid");
			}
			
		})
		
		//비밀번호 값 체크 
		$('#password').on("change", function(){
			isPasswdValid=false;
			isPasswdReCk = false;
			
			this.classList.remove("is-valid");
			this.classList.remove("is-invalid");
			
			$("#passwdInputCk").removeClass("is-valid");
			$("#passwdInputCk").addClass("is-invalid");
			
			let passwd = this.value;
			
			isPasswdValid = patternPasswd(passwd);
			if(isPasswdValid){
				this.classList.remove("is-invalid");
		        this.classList.add("is-valid");
			}else{ 
					this.classList.remove("is-valid");
	         		this.classList.add("is-invalid");
	        }
		})
		
		
		//아이디 중복체크
		$('#checkId').on("click", function(){
			IdLastCK = false;
			
			let id = document.getElementById("user_name").value;
			
			console.log(id);
			
			let data ={};
			data.user_name = id;
			
			let idinput = document.getElementById("user_name");
			let idlastCK = document.getElementById("IdLastCK");
			let idclass = $('#user_name').attr('class');
			console.log(idclass);
			if(idclass.match("is-invalid")){
				alert("아이디 형식을 맞춰주세요!");
			}else{
				$.ajax({
					url: '/user/checkId.do',
					method: 'POST',
					data: JSON.stringify(data),
					contentType: 'application/json',
					success: function (result) {
						if(result=="true"){
							$('#idinputDiv').find('div.valid-feedback').text("사용할 수 있는 아이디 입니다!");
							 $("#checkId").attr("disabled", true);
							IdLastCK = true;
							console.log("트루인지"+IdLastCK);
							
						}else{
							alert("중복되는 아이디가 있습니다. 새 아이디를 입력해주세요.");
							idinput.classList.remove("is-valid");
					        //idinput.classList.add("is-invalid");
							$('.idInput').val(" ");
							 $("#checkId").attr("disabled", true);
						}
					},
					error: function (error) {
						console.log(error);
						alert('실패');
					}
				})	
			}
				

		})
		
		//비밀번호 체크를 체크
		$('#passwdInputCk').on("change", function(){
			isPasswdReCk = false;
			
			let passwd = $('.passwdInput').val();
			let passwdck = $('#passwdInputCk').val();
			
			isPasswdReCk = passwd==passwdck;
			if(isPasswdReCk){
				this.classList.remove("is-invalid");
		        this.classList.add("is-valid");
			}else{
				this.classList.add("is-invalid");
		        this.classList.remove("is-valid");

			}
		});
		
	/* 	//회원가입
		$('#applyBtn').on("click", function(){
           
            let idck = $('#idck').val();
            let pwck = $('#pwck').val();
            if(idck == 'false'){
            	alert("아이디를 확인해주세요.");
            	return;
            }
            if(pwck == 'false'){
            	alert("비밀번호를 확인해 주세요.");
            	return;
            }

			if(idck == 'true' || pwck == 'true'){
				applyUser();
			}
		}); */
		
		document.querySelector("#inputFrm").addEventListener("submit", function(e){
			console.log(isIDValid);
			console.log(isPasswdValid);
			console.log(isPasswdReCk);
			console.log(IdLastCK);
			
		      if(!isIDValid || !isPasswdValid || !isPasswdReCk || !IdLastCK){
		       	alert("입력 사항들을 다시 확인해 주세요"); 

		         e.preventDefault();
		      }
		  });
		
		function applyUser(){
			var param = document.getElementById('inputFrm');
			var formData = new FormData(param);

			console.log(formData)

			$.ajax({
				url: '/user/applyUser.do',
				type: 'POST',
				data: formData,				
				processData : false, 
				contentType : false,			
				success: function (result) {
					alert("회원가입 완료되었습니다!");
					location.href="/board/boardList.do";
				},
				error: function (error) {
					console.log(error);
					alert('실패');
				}
			}) 
			
		}
	</script>
</body>
</html>
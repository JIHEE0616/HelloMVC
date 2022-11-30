<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="/views/common/header.jsp"%>


<section id=enroll-container>
        <h2>회원 가입 정보 입력</h2>
        <!-- form태그에 name을 지정하면 :  -->
        <form name="enrollMemberFrm" action="<%=request.getContextPath()%>/member/enrollMemberEnd.do" method="post" 
        			onsubmit="return fn_invalidate();" > <!-- onsubmit에서 반환되는 것이 true면 회원가입 완료로 종료, false면 X -->
        <table>
			<tr>
				<th>아이디</th>
				<td>
					<input type="text" placeholder="4글자이상" name="userId" id="userId_" >
					<input type="button" value="중복확인" onclick="fn_idduplicate();">
				</td>
				
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" name="password" id="password_" onchange="pwd();"><br>
					
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" id="password_2" ><br><!-- onchange="pwd();" -->
					<span id="passwordcheck"></span> 
				</td>
			</tr>  
			<tr>
				<th>이름</th>
				<td>	
				<input type="text"  name="userName" id="userName" ><br>
				</td>
			</tr>
			<tr>
				<th>나이</th>
				<td>	
				<input type="number" name="age" id="age"><br>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" placeholder="abc@xyz.com" name="email" id="email"><br>
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required><br>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>	
					<input type="text" placeholder="" name="address" id="address"><br>
				</td>
			</tr>
			<tr>
				<th>성별 </th>
				<td>
					<input type="radio" name="gender" id="gender0"  value="M">
					<label for="gender0">남</label>
					<input type="radio" name="gender" id="gender1" value="F">
					<label for="gender1">여</label>
				</td>
			</tr>
			<tr>
				<th>취미 </th>
				<td>
					<input type="checkbox" name="hobby" id="hobby0" value="운동"><label for="hobby0" >운동</label>
					<input type="checkbox" name="hobby" id="hobby1" value="등산"><label for="hobby1">등산</label>
					<input type="checkbox" name="hobby" id="hobby2" value="독서"><label for="hobby2">독서</label><br />
					<input type="checkbox" name="hobby" id="hobby3" value="게임"><label for="hobby3">게임</label>
					<input type="checkbox" name="hobby" id="hobby4" value="여행"><label for="hobby4">여행</label><br />
				</td>
			</tr>
		</table>
		<input type="submit" value="가입" >
		<input type="reset" value="취소">
        </form>
        
        <form name="duplicateIdFrm">
					<input type="hidden" name="userId">
		</form>
    </section>
    <script>
    	//스크립트
	   /*  const pwd=()=>{  //비밀번호일치여부
	        if(document.querySelector("#password_").value!=''&&document.querySelector("#password_2").value!=''){
		        if(document.querySelector("#password_").value==document.querySelector("#password_2").value){
		            document.querySelector("span#passwordcheck").innerHTML="비밀번호가 일치합니다";
		            document.querySelector("span#passwordcheck").style.color='green';
		        }else{
		            document.querySelector("span#passwordcheck").innerHTML="비밀번호가 일치하지 않습니다.";
		            document.querySelector("span#passwordcheck").style.color='red';
		        }
	    	}
	    } */
	    
	    //제이쿼리
	    $(()=>{
	    	$("#password_2").blur(e=>{  //비밀번호일치여부
	    		const pw=$("#password_").val();
	    		const pwck=$(e.target).val();
	    		/* if(pw.length>=8 && pwck.length>=8){ */
	    			if(pw==pwck){
		    			$("#passwordcheck").css("color","green").text("비밀번호가 일치합니다.");
		    		}else{
		    			$("#passwordcheck").css("color","red").text("비밀번호가 불일치합니다.");
		    		}
	    		/*{ else{
	    			alert("비밀번호는 8글자이상이여야 합니다.");
	    		} */
	    		
	    	});
	    }) 
	    
	    const fn_idduplicate=()=>{ //아이디중복확인
	    	const userId=$("#userId_").val();
	    	/* console.log(userId); */
	    	if(userId.trim().length<4){
	    		alert('아이디는 4글자 이상 입력해야합니다.');
	    		$("#userId_").val();
	    		$("#userId_").focus();
    		}else{
    			<%-- open("<%=request.getContextPath()%>/member/idDuplicate.do?userId="+userId,"_blank","width=300,height=300");  --%>
    			const title="idDuplicateFrm";
    			open("",title,"width=300 height=300");
    			console.log(duplicateIdFrm);
    			duplicateIdFrm.userId.value=userId;
    			duplicateIdFrm.method="post";
    			duplicateIdFrm.action="<%=request.getContextPath()%>/member/idDuplicate.do"
    			duplicateIdFrm.target=title;
    			duplicateIdFrm.submit();
    		}
	    	
	    }
	    
	    const fn_invalidate=()=>{
    		//아이디가 4글자 이상
    		const userId=$("#userId_").val().trim();
    		//패스워드가 8글자 이상입력 되어야만 넘어감
    		const password=$("#password_").val().trim();
    		if(userId.length<4){
    			alert("아이디는 4글자 이상 입력하세요");
    			return false;
    		}
    		
    		const passwordReg=/^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()])[A-Za-z\d!@#$%^&*()]{8,}$/;
            //console.log(!passwordReg.test(password));
    		if(!passwordReg.test(password)){
                alert("패스워드는 8글자 이상 특수기호,영문자,숫자 포함해야합니다");
                return false;
             }
	    		
	    }
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	    
	</script>
    
<%@ include file="/views/common/footer.jsp"%>
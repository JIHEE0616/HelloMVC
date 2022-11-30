<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.web.member.model.vo.Member,java.util.List,java.util.Arrays" %>
<%
	List<Member> list=(List<Member>)request.getAttribute("memberList");
%>

<%@ include file="/views/common/header.jsp"%>   
    
<style type="text/css">
	section#memberList-container {text-align:center;}
	
	section#memberList-container table#tbl-member {width:100%; border:1px solid gray; border-collapse:collapse;}
	section#memberList-container table#tbl-member th, table#tbl-member td {border:1px solid gray; padding:10px; }
</style>
    
    <section id="memberList-container">
        <h2>회원관리</h2>
        <table id="tbl-member">
            <thead>
                <tr>
                    <th>아이디</th>
				    <th>이름</th>
				    <th>성별</th>
				    <th>나이</th>
				    <th>이메일</th>
				    <th>전화번호</th>
				    <th>주소</th>
				    <th>취미</th>
				    <th>가입날짜</th>
                </tr>
            </thead>
            <tbody>
       	   <!--  조회된 결과가 없으면 한줄(row)로 결과가 없습니다 출력하고
	    조회된 결과가 있으면 각 객체를 tr로 출력하는 구문을 작성할것 -->
	    
	    	<% if(list.isEmpty()){ %>
	    		<tr>
	    			<td><h3>조회된 회원이 없습니다</h3></td>
	    		</tr>
	    		<% } else{
	    			for(Member m : list){ %>
				    	<tr>
				    		<td><%=m.getUserId() %></td>
						    <td><%=m.getUserName() %></td>
						    <td><%=m.getGender() %></td>
						    <td><%=m.getAge() %></td>
						    <td><%=m.getEmail() %></td>
						    <td><%=m.getPhone() %></td>
						    <td><%=m.getAddress() %></td>
						 <%--    <td><%= Arrays.toString(m.getHobby()) %></td> --%>
						    <td><%= String.join(",",m.getHobby()) %></td>
						    <td><%=m.getEnrollDate() %></td>
				    	</tr>
		    	<% } 
		    	}%>
	    	
	    
            </tbody>
        </table>
    </section>
    <script>
    	
    </script>
 <%@ include file="/views/common/footer.jsp"%>
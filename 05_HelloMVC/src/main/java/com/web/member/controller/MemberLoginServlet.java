package com.web.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.web.member.model.service.MemberService;
import com.web.member.model.vo.Member;

/**
 * Servlet implementation class MemberLoginServlet
 */
@WebServlet(name="login", urlPatterns="/login.do")
public class MemberLoginServlet extends HttpServlet {
	MemberService service=new MemberService();
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인처리 기능하는 서블릿
		//클라이언트가 보낸 id, password를 가지고 db에 일치하는 데이터가 있는지 확인하고 있으면 데이터를 가져오고 없으면 null값을 가져오는 기능
		request.setCharacterEncoding("utf-8");
		
		String userId=request.getParameter("userId");
		String password=request.getParameter("password");
		Member m=service.loginMember(userId, password); 
		
		//아이디저장로직구현하기
		//클라이언트가 아이디저장 체크박스를 체크 후 로그인 성공시 저장O  ->  "on"
		//클라이언트가 아이디저장 체크박스를 체크 하지 않았으면 저장X  ->  null
		String saveId=request.getParameter("saveId");
		
		
		//웹 애플리케이션에서 로그인처리하기
		//로그인 후 로그인한 정보는 session에 저장한다
		if(m!=null) { //로그인한 정보가 있을때 = 로그인 성공시
			HttpSession session=request.getSession();
			session.setAttribute("loginMember", m);
			
			if(saveId!=null) { //아이디저장 체크시
				Cookie idCookie=new Cookie("saveId",userId);
				idCookie.setMaxAge(60*60*24*7); //일주일
				response.addCookie(idCookie);
			}else { //아이디저장 체크해제시
				Cookie idCookie=new Cookie("saveId","");
				idCookie.setMaxAge(0);
				response.addCookie(idCookie);
			}
			//응답할 페이지를 구성 -> jsp
			//로그인 정보는 session에 저장되므로 로그인로직이 계속 돌아가는 것을 방지하기 위해 
			//Dispatcher가 아닌 sendRedirect로 보냄
			response.sendRedirect(request.getContextPath());
			
		}else { //로그인 실패시
			request.setAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request,response);
		}
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

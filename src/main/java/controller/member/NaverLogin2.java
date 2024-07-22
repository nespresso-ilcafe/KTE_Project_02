package controller.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dto.Member;

@WebServlet("/member/naver")
public class NaverLogin2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public NaverLogin2() {
		super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    Date date = new Date();
	    SimpleDateFormat sim = new SimpleDateFormat();
	    String signdate = sim.format(date);
	    
	    String id  = request.getParameter("useremail");
	    MemberDAO dao = new MemberDAO();
	    
	    int num = dao.loginOk(id); // 아이디 존재여부
	    HttpSession session = request.getSession();
	    
	    if (num == 1) { // 아이디 존재
	        Member m = dao.oneMember(id); // 회원정보

	        session.setAttribute("id", m.getId());
	        session.setAttribute("name", m.getName());
	        session.setAttribute("connecttype", m.getConnecttype());
	        session.setAttribute("level", m.getLevel());
	    } else {
	        dao.insertMemberApi2(id, signdate); // 회원가입 처리(네이버)

	        session.setAttribute("id", id);
	        session.setAttribute("name", "네이버로그인");
	        session.setAttribute("connecttype", "네이버");
	        session.setAttribute("level", "1");
	        session.setAttribute("signdate", signdate);
	    }
	    
	    if (session.getAttribute("name").equals("네이버로그인")) {
	        response.sendRedirect("/member/modify");
	    } else {
	        response.sendRedirect("/");
	    }
	}

}
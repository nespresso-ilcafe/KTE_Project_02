package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dto.Member;

@WebServlet("/member/modify")
public class MemberModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberModify() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String session_id = (String)session.getAttribute("id");
		
		if(session_id == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			
			out.print("<script>");
			out.print("alert('로그인 후 이용가능합니다.');");
			out.print("history.back();");
			out.print("</script>");
		}else {
			MemberDAO dao = new MemberDAO();
			Member m = dao.oneMember(session_id);
			
			request.setAttribute("modify", m);
			RequestDispatcher dis = request.getRequestDispatcher("/member/modify.jsp");
			dis.forward(request, response);
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 생년월일 변수
        String bir1 = request.getParameter("mb_bir1");
        String bir2 = request.getParameter("mb_bir2");
        String bir3 = request.getParameter("mb_bir3");
        String bir = bir1 + "-" + bir2 + "-" + bir3;

        // 폰번호 변수
        String pn1 = request.getParameter("mb_pn1");
        String pn2 = request.getParameter("mb_pn2");
        String pn3 = request.getParameter("mb_pn3");
        String pn = pn1 + "-" + pn2 + "-" + pn3;

        // 메일 변수
        String mail1 = request.getParameter("mb_email1");
        String mail2 = request.getParameter("mb_email2");
        String mail3 = request.getParameter("mb_email3");

        String email = "";
        if (mail2 != null && !mail2.isEmpty()) {
            email = mail1 + "@" + mail2;
        }
		
		Member m = new Member();
		
		m.setId(request.getParameter("md_id"));
		m.setPass(request.getParameter("md_pass"));
		m.setName(request.getParameter("md_name"));
		m.setBirth(bir);
		m.setPn(pn);
		m.setEmail(email);
		m.setZc(request.getParameter("md_zc"));
		m.setZc1(request.getParameter("md_zc1"));
		m.setZc2(request.getParameter("md_zc2"));
		m.setZc3(request.getParameter("md_zc3"));
		m.setZc4(request.getParameter("md_zc4"));
		m.setGender(request.getParameter("md_gender"));
		
		MemberDAO dao = new MemberDAO();
		
		dao.updateMember(m);
		
		response.sendRedirect("/");
	}
}

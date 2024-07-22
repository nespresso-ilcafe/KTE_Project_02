package controller.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dto.Member;


@WebServlet("/member/mypage")
public class MyPage extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MyPage() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String session_id = (String)session.getAttribute("id");
		
		MemberDAO dao = new MemberDAO();
		Member m = dao.oneMember(session_id);
		request.setAttribute("m", m);
		
		RequestDispatcher dis = request.getRequestDispatcher("mypage.jsp");
		dis.forward(request, response);
	}
}

package admin.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminMemberDAO;
import dto.Member;

@WebServlet("/admin/member/view")
public class AdminMemberView extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminMemberView() {
        super();

    }

    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		AdminMemberDAO dao = new AdminMemberDAO();
		Member member = dao.oneMember(id);
		
		request.setAttribute("m", member);
		RequestDispatcher dis = request.getRequestDispatcher("/admin/member/view.jsp");
		dis.forward(request, response);
	}

}

package admin.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminMemberDAO;
import dto.Member;


@WebServlet("/admin/member/modify")
public class AdminMemberModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminMemberModify() {
        super();
 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		
		AdminMemberDAO dao = new AdminMemberDAO();
		Member m = dao.oneMember(id);
		
		request.setAttribute("modify", m);
		RequestDispatcher dis = request.getRequestDispatcher("/admin/member/modify.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		Member m = new Member();
		
		m.setId(request.getParameter("md_id"));
		m.setPass(request.getParameter("md_pass"));
		m.setName(request.getParameter("md_name"));
		m.setBirth(request.getParameter("md_birth"));
		m.setPn(request.getParameter("md_pn"));
		m.setEmail(request.getParameter("md_email"));
		m.setZc(request.getParameter("md_zc"));
		m.setZc1(request.getParameter("md_zc1"));
		m.setZc2(request.getParameter("md_zc2"));
		m.setZc3(request.getParameter("md_zc3"));
		m.setZc4(request.getParameter("md_zc4"));
		m.setSigndate(request.getParameter("md_signdate"));
		m.setConnecttype(request.getParameter("md_connecttype"));
		m.setLevel(request.getParameter("md_level"));
		m.setStatus(request.getParameter("md_status"));
		m.setGender(request.getParameter("md_gender"));
		
		AdminMemberDAO dao = new AdminMemberDAO();
		dao.updateMember(m);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print("<script>");
		out.print("opener.location.reload();");
		out.print("self.close();");
		out.print("</script>");
	}

}

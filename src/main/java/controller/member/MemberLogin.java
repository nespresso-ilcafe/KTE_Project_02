package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.mail.Session;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.MemberDAO;
import dto.Member;

@WebServlet("/member/login")
public class MemberLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public MemberLogin() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
        dis.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("mb_id");
        String pass = request.getParameter("mb_pass");

        MemberDAO dao = new MemberDAO();
        Member m = dao.MemberLogin(id, pass);
        
        if (m.getId() != null && !m.getId().equals("")) {
           if( m.getStatus().equals("정상")) {
             HttpSession session = request.getSession();
             
             session.setAttribute("id", m.getId());
             session.setAttribute("level", m.getLevel());
             session.setAttribute("name", m.getName());
             session.setAttribute("connecttype", m.getConnecttype());
             response.setContentType("text/html; charset=utf-8");
             PrintWriter out = response.getWriter();
             
             out.println("<script>alert('로그인이 완료되었습니다.');window.location.href='/';</script>");
             
          }else {         
             response.setContentType("text/html; charset=utf-8");
             PrintWriter out = response.getWriter();
               
             out.print("<script>");
             out.print("alert('"+m.getStatus()+" 처리된 아이디 입니다. 로그인 하실 수 없습니다.');");
             out.print("history.back();");
             out.print("</script>");
          }
        }else {
           response.setContentType("text/html; charset=utf-8");
         PrintWriter out = response.getWriter();
           
           out.print("<script>");
         out.print("alert('아이디나 비밀번호를 확인하세요.');");
         out.print("history.back();");
         out.print("</script>");
        
        }
        
    }
}
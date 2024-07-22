package controller.notice;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDAO;
import dto.Notice;


@WebServlet("/notice/noticemodify")
public class NoticeModify extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeModify() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		NoticeDAO dao = new NoticeDAO();
		Notice n = dao.oneNotice(uid);
		
		request.setAttribute("n", n);
		
		RequestDispatcher dis = request.getRequestDispatcher("noticeModify.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		Notice n = new Notice();
	      
		n.setUid(uid);
	    n.setSubject(request.getParameter("subject"));
	    n.setComment(request.getParameter("comment"));
		
		NoticeDAO dao = new NoticeDAO();
		dao.updateNotice(n);
		
		response.sendRedirect("noticelist");
	}
}

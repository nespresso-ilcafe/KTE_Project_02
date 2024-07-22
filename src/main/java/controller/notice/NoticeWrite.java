package controller.notice;

import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import dao.ItemDAO;
import dao.NoticeDAO;
import dto.Notice;

@WebServlet("/notice/write")
public class NoticeWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeWrite() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("noticeWrite.jsp");
	    dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  request.setCharacterEncoding("utf-8");
	      
	      //오늘 날짜
	      java.util.Date today = new java.util.Date();
	      SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	      String signdate = cal.format(today);
	      
	      Notice n = new Notice();
	      
	      n.setId(request.getParameter("id"));
	      n.setName(request.getParameter("name"));
	      n.setSubject(request.getParameter("subject"));
	      n.setComment(request.getParameter("comment"));
	      n.setSigndate(signdate);
	      n.setGongji(request.getParameter("gongji"));
		  
		  NoticeDAO dao = new NoticeDAO();      

	      dao.insertNotice(n); 

	      response.sendRedirect("noticelist");
	}
}

package controller.notice;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CommentDAO;
import dto.Comment;

@WebServlet("/notice/comment1")
public class NoticeComment extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeComment() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String tb_table = request.getParameter("tb_table");
		int tb_uid = Integer.parseInt(request.getParameter("tb_uid"));
		String tb_id = request.getParameter("tb_id");
		String tb_comment = request.getParameter("tb_comment");

		//오늘 날짜
	    java.util.Date today = new java.util.Date();
	    SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	    String signdate = cal.format(today);
	   
	    CommentDAO dao = new CommentDAO();
	    
	    Comment c = new Comment();
	    c.setTb_table(tb_table);
	    c.setTb_uid(tb_uid);
	    c.setTb_id(tb_id);
	    c.setTb_comment(tb_comment);
	    c.setTb_date(signdate);
	    
	    dao.addComment(c);
	}
}

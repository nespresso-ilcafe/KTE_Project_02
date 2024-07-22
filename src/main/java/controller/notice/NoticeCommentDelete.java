package controller.notice;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CommentDAO;

@WebServlet("/notice/commentdelete")
public class NoticeCommentDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeCommentDelete() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));

		CommentDAO dao = new CommentDAO();
		dao.oneDelete(uid);
	}
}

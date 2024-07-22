package controller.notice;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.NoticeDAO;

@WebServlet("/notice/delete")
public class NoticeDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public NoticeDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		NoticeDAO dao = new NoticeDAO();
		dao.oneDelete(uid);
		
		response.sendRedirect("noticelist");
	}
}

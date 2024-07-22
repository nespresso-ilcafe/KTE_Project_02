package controller.orderbbs;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.OrderbbsDAO;


@WebServlet("/orderbbs/delete")
public class OrderbbsDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OrderbbsDelete() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int uid = Integer.parseInt(request.getParameter("uid"));
		
		OrderbbsDAO dao = new OrderbbsDAO();
		dao.oneDelete(uid);
		
		response.sendRedirect("orderbbslist");
	}
}

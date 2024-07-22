package controller.Item;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;
import dto.Category;
import dto.Reviews;


@WebServlet("/item/reviewsview")
public class ReviewsView extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ReviewsView() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ItemDAO dao = new ItemDAO();
		
		String category2 = request.getParameter("category2");
		int rv_uid = Integer.parseInt(request.getParameter("rv_uid"));
		
		Reviews re = dao.oneReview(rv_uid);
		request.setAttribute("re", re);
		
		Category ca = dao.getMiddle(category2);
		request.setAttribute("ca", ca);

		RequestDispatcher dis = request.getRequestDispatcher("reviewsview.jsp");
		dis.forward(request, response);
	}
}

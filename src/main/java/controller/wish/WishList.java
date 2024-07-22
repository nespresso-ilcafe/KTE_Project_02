package controller.wish;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WishDAO;
import dto.Wish;

@WebServlet("/wish/wishlist")
public class WishList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public WishList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		
		WishDAO dao = new WishDAO();
		
		int count = 0;
		count = dao.getAllcount(id);
		
		ArrayList<Wish> w = dao.getAllWish(id);
		
		request.setAttribute("w", w);
		request.setAttribute("count", count);
		
		RequestDispatcher dis = request.getRequestDispatcher("/wish/wishlist.jsp");
		dis.forward(request, response);
	}
}

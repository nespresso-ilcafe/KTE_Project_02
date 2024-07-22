package controller.cart;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;


@WebServlet("/cart/qtydelete")
public class QtyDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public QtyDelete() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CartDAO dao = new CartDAO();
		
		response.sendRedirect("/cart/cartlist");
	}
}

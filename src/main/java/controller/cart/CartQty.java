package controller.cart;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;


@WebServlet("/cart/qty_update")
public class CartQty extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CartQty() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int ct_uid = Integer.parseInt(request.getParameter("ct_uid"));
		String str = request.getParameter("str");
		
		CartDAO dao = new CartDAO();
		
		dao.ptyUpdate(ct_uid,str);
	}
}

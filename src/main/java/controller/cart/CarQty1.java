package controller.cart;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;
import dto.Cart;

@WebServlet("/cart/cartqty1")
public class CarQty1 extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CarQty1() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mb_id = request.getParameter("mb_id");
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		
		CartDAO dao = new CartDAO();
		
		int num = dao.getAllqty(mb_id, it_uid);
		
		response.setContentType("text/html; charset=utf-8");
  	    PrintWriter out = response.getWriter();
  	    
  	    out.print(num);
	}
}

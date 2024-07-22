package controller.cart;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import dao.ItemDAO;
import dao.UserOrderDAO;
import dto.Cart;
import dto.CartMember;
import dto.Item;
import dto.Orders;
import dto.OrdersItem;


@WebServlet("/cart/orderlist")
public class OrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OrderList() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CartDAO dao = new CartDAO();
		
		String mb_id = request.getParameter("mb_id");
		String[] ct_uids = request.getParameterValues("ct_uids[]");
		
		ArrayList<CartMember> cm = dao.forOrderList(mb_id, ct_uids);
		
		request.setAttribute("cm", cm);
        request.setAttribute("ct_uids", ct_uids);
                
		RequestDispatcher dispatcher = request.getRequestDispatcher("orderlist.jsp");
        dispatcher.forward(request, response);
    }
}

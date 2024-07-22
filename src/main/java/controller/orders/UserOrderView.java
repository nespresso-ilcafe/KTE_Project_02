package controller.orders;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminOrderDAO;
import dao.UserOrderDAO;
import dto.Orders;
import dto.OrdersItem;


@WebServlet("/orders/userorderview")
public class UserOrderView extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserOrderView() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mb_id = request.getParameter("mb_id");
		String od_id = request.getParameter("od_id");
		UserOrderDAO dao = new UserOrderDAO();
		
		ArrayList<OrdersItem> orArr = dao.getOneOrder(od_id);
		request.setAttribute("orArr", orArr);
		request.setAttribute("mb_id", mb_id);
		request.setAttribute("od", od_id);
		
		RequestDispatcher dis = request.getRequestDispatcher("userorderview.jsp");
		dis.forward(request, response);
	}
}

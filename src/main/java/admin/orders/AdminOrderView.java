package admin.orders;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminOrderDAO;
import dto.Orders;


@WebServlet("/admin/orders/adminorderview")
public class AdminOrderView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AdminOrderView() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String od_id = request.getParameter("od_id");

		AdminOrderDAO dao = new AdminOrderDAO();
		
		ArrayList<Orders> orArr = dao.getAllOrder(od_id);
		request.setAttribute("a", orArr);
		
		RequestDispatcher dis = request.getRequestDispatcher("adminorderview.jsp");
		dis.forward(request, response);
		
	}

}

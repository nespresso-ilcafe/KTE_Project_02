package admin.orders;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.AdminOrderDAO;
import dao.CartDAO;


@WebServlet("/admin/orders/ordersend")
public class AdminOrderSend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AdminOrderSend() {
        super();
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String od_id = request.getParameter("od_id");
		
		AdminOrderDAO dao = new AdminOrderDAO();
		dao.orderSend(od_id);
		
		response.sendRedirect("/admin/orders/adminorderlist");
		
	}

}

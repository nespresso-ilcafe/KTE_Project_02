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


@WebServlet("/orders/userorderlist")
public class UserOrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UserOrderList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int pageSize = 5;
		//현재 페이지
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum= Integer.parseInt(request.getParameter("pageNum"));
		}
		
		UserOrderDAO dao = new UserOrderDAO();
		
		String field = request.getParameter("field");
		String search = request.getParameter("search");
		String id = request.getParameter("mb_id");
		//전체 게시글 수
		int count = dao.getAllcount(id, field, search);
		//넘버링
		int number = count - (pageNum-1) * pageSize;
		int startRow = (pageNum-1) * pageSize;
		int endRow = pageSize;
		
		ArrayList<Orders> orArr = dao.getOrderList(id, startRow, endRow, field, search);
		
		request.setAttribute("a", orArr);
		request.setAttribute("count", count);
		request.setAttribute("field", field);
		request.setAttribute("search", search);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("number", number);
		
		RequestDispatcher dis = request.getRequestDispatcher("userorderlist.jsp");
		dis.forward(request, response);
	}
}

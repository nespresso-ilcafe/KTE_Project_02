package controller.cart;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import dao.ItemDAO;
import dto.Cart;
import dto.CartMember;
import dto.Category;
import dto.Item;
import dto.Member;
import dto.Orders;


@WebServlet("/cart/cartlist")
public class CartList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CartList() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//페이징//
		//한페이지 당 상품 수
		int pageSize = 10;
		
		//페이지 넘버링용 
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		//총 상품 수 초기화 
		int count = 0;
		
		//한 페이지 상품 수 초기화 
		int number = 0;
		CartDAO dao = new CartDAO();
		ItemDAO idao = new ItemDAO();
		
		//전체 상품 수
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		count = dao.getAllcount(id);
		
		//한 페이지에 들어갈 상품 수 설정 (limit)
		//전체 게시물 수 - (현재 페이지-1) * 페이지당 상품 수 (4)
		//=인덱스 0부터 4개 만들기위함
		int startRow = (pageNum - 1) * pageSize;
		int endRow = pageSize;
		
		ArrayList<Cart> v = dao.getAllMember(id);
		
		//넘버링 숫자 
		number = count - (pageNum - 1) * pageSize;
		
		request.setAttribute("v", v);
		request.setAttribute("number", number);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("count", count);
		request.setAttribute("pageNum", pageNum);
		
		RequestDispatcher dis = request.getRequestDispatcher("cartlist.jsp");
		dis.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] ct_uids = request.getParameterValues("ct_uids[]");
		response.sendRedirect("/cart/orderlist");
	}
}

package controller.Item;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import dao.CategoryDAO;
import dao.ItemDAO;

import dto.Cart;
import dto.Category;
import dto.Item;
import dto.Reviews;
import dto.ItemQna;


@WebServlet("/item/view")
public class ItemView extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ItemView() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String category1 = request.getParameter("category1");
		String category2 = request.getParameter("category2");
		String od_id = request.getParameter("od_id");
		request.setAttribute("category1", category1);
		request.setAttribute("category2", category2);
		request.setAttribute("od_id", od_id);
		
		//////////상품 관련 
		ItemDAO dao = new ItemDAO();
		//아이템 불러오기
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		Item it = dao.oneItem(it_uid);
		request.setAttribute("it", it);
		//카테고리 불러오기
		String ca_id = request.getParameter("category2");
		Category ca = dao.getMiddle(ca_id);
		request.setAttribute("ca", ca);
		
		//////////상품 페이지 리뷰영역
		//리뷰페이징
		int pageSize = 5;
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		String field = request.getParameter("field");
		String search = request.getParameter("search");
		
		int rcount = dao.getAllcountReview(field, search, it_uid);
		int number = rcount - (pageNum - 1) * pageSize;
		int startRow = (pageNum - 1) * pageSize;
		int endRow = pageSize;
		
		ArrayList<Reviews> rv = dao.getSomeReviews(it_uid);
		request.setAttribute("rv", rv);
		request.setAttribute("rcount", rcount);
		request.setAttribute("field", field);
		request.setAttribute("search", search);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("number", number);
		
		//리뷰 평점 
		double average = dao.reviewsRating(it_uid);
		request.setAttribute("average", average);
		
		//////////상품 페이지 계층형
		int qpageSize = 10;
		int qpageNum = 1;
		if(request.getParameter("pageNum") != null) {
			qpageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		int qcount = dao.getAllcountIQ(field, search, it_uid);
		
		int qnumber = qcount - (qpageNum - 1) * qpageSize;
		int qstartRow = (qpageNum - 1) * qpageSize;
		int qendRow = qpageSize;
		
		ArrayList<ItemQna> q = dao.someItemQna(qstartRow, qendRow, it_uid, field, search);
		request.setAttribute("q", q);
		
		request.setAttribute("qcount", qcount);
		request.setAttribute("qpageNum", qpageNum);
		request.setAttribute("qpageSize", qpageSize);
		request.setAttribute("qnumber", qnumber);
		
		RequestDispatcher dis = request.getRequestDispatcher("/item/itemview.jsp");
		dis.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");

		HttpSession session = request.getSession();
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);
		
		Cart c = new Cart();
		
		c.setMb_id((String)session.getAttribute("id"));
		c.setIt_uid(Integer.parseInt(request.getParameter("it_uid")));
		c.setIt_price (Integer.parseInt(request.getParameter("it_price")));
		c.setIt_point(Integer.parseInt(request.getParameter("it_point")));
		c.setIt_qty(Integer.parseInt(request.getParameter("qty"))); //구매수량
		c.setCt_status("준비");
		c.setCt_date(signdate);
		
		CartDAO dao = new CartDAO();
		
		//장바구니 존재 여부
		int num = dao.selectItem(c);

		if(num == 0) {
			dao.insertCart(c); //장바구니 담기
		}else {
			dao.oneUpdate(c);
		}		

		String order = request.getParameter("order");

		if(order.equals("c")) { //장바구니			
			response.sendRedirect("list"); // 장바구니 목록 이동
		}else { //바로구매			
			response.sendRedirect("/admin/order/write"); // 구매 페이지 이동
		}
	}
}

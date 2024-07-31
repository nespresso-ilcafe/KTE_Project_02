package controller.wish;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WishDAO;
import dto.Cart;
import dto.Wish;

@WebServlet("/wish/wishinsertcart")
public class WishInsertCart extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public WishInsertCart() {
        super();
 
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
		
		//오늘 날짜
        java.util.Date today = new java.util.Date();
        SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String signdate = cal.format(today);
		
		HttpSession session = request.getSession();
		String od_id = (String)session.getAttribute("cart");
		String mb_id = (String)session.getAttribute("id");
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		int it_price = Integer.parseInt(request.getParameter("it_price"));
		int it_sale = Integer.parseInt(request.getParameter("it_sale"));
		int it_point = Integer.parseInt(request.getParameter("it_point"));
		int it_qty = Integer.parseInt(request.getParameter("it_qty"));
		String it_opt1 = request.getParameter("it_opt1");
		
		WishDAO dao = new WishDAO();
		
		Cart c = new Cart();
		
	    c.setMb_id(mb_id);
	    c.setIt_uid(it_uid);
	    c.setIt_price(it_price);
	    c.setIt_sale(it_sale);
	    c.setIt_point(it_point);
	    c.setIt_qty(it_qty);
	    c.setCt_date(signdate);
	    c.setIt_opt1(it_opt1);
	    
	    dao.oneInsertCart(c);
	    
	    response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		out.print("<script>");
		out.print("alert('장바구니에 항목을 추가하였습니다.');");
		out.print("location.href='wishlist';");
		out.print("</script>");
	
	}

}

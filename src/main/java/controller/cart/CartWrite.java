package controller.cart;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.CartDAO;
import dto.Cart;


@WebServlet("/cart/write")
public class CartWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CartWrite() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		int qty1 = Integer.parseInt(request.getParameter("qty1"));
		int qty = Integer.parseInt(request.getParameter("qty"));
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));

		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		//오늘 날짜
		java.util.Date today = new java.util.Date();
		SimpleDateFormat cal = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String signdate = cal.format(today);
		
		String opt1 = request.getParameter("gloOpt1");
		String opt2 = request.getParameter("gloOpt2");
		String opt = opt1 + " / " + opt2;
		if(opt1 == null) {
			opt = "옵션이 없습니다.";
		}
		
		Cart c = new Cart();
		
		int point = Integer.parseInt(request.getParameter("it_point")) * qty;

		c.setMb_id((String)session.getAttribute("id"));
		c.setIt_uid(Integer.parseInt(request.getParameter("it_uid")));
		c.setIt_price (Integer.parseInt(request.getParameter("it_price")));
		c.setIt_sale(Integer.parseInt(request.getParameter("it_sale")));
		c.setIt_point(point);
		c.setIt_qty(Integer.parseInt(request.getParameter("qty"))); //구매수량
		c.setCt_status("준비");
		c.setCt_date(signdate);
		c.setIt_opt1(opt);

		CartDAO dao = new CartDAO();

		//장바구니 존재 여부
		int num = dao.selectItem(c);

		if(num == 0) {
			dao.insertCart(c); //장바구니 담기
		}else {
			dao.oneUpdate(c);
		}
		
		response.sendRedirect("/cart/cartlist"); // 장바구니 목록 이동
	}
}

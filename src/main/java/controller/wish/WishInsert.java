package controller.wish;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.WishDAO;
import dto.Comment;
import dto.Wish;

@WebServlet("/wish/wishinsert")
public class WishInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public WishInsert() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		String user_id = (String)session.getAttribute("id");
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		String it_name = request.getParameter("it_name");
		int it_price = Integer.parseInt(request.getParameter("it_price"));
		int it_sale = Integer.parseInt(request.getParameter("it_sale"));
		int qty = Integer.parseInt(request.getParameter("qty"));
		int it_point = Integer.parseInt(request.getParameter("it_point"));
		String it_op1 = request.getParameter("it_op1");
		String it_op2 = request.getParameter("it_op2");
		String it_option = it_op1 + " / " + it_op2;
		
		if(it_op1.equals("선택안함")) {
			it_option = "옵션이 없습니다.";
		}
		
		WishDAO dao = new WishDAO();
		
		Wish w = new Wish();
		
	    w.setUser_id(user_id);
	    w.setIt_uid(it_uid);
	    w.setIt_name(it_name);
	    w.setIt_price(it_price);
	    w.setQty(qty);
	    w.setIt_option(it_option);
	    w.setIt_point(it_point);
	    w.setIt_sale(it_sale);
	    
		dao.oneInsert(w);
		
		response.sendRedirect("wishlist");
	}

}

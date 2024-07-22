package controller.cart;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import dao.MemberDAO;
import dao.UserOrderDAO;
import dto.Cart;
import dto.CartMember;
import dto.Item;
import dto.Member;
import dto.Orders;


@WebServlet("/cart/directorder")
public class DirectOrderList extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public DirectOrderList() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	RequestDispatcher dis = request.getRequestDispatcher("/cart/directordercart.jsp");
		dis.forward(request, response);
		
	    request.setCharacterEncoding("utf-8");
	    HttpSession session = request.getSession();
	    
	    //주문자 정보
	    String id = (String)session.getAttribute("id");
	    Member m = new Member();
	    MemberDAO mdao = new MemberDAO();
	    m = mdao.oneMember(id);
	    
	    //아이템 정보
		int qty = Integer.parseInt(request.getParameter("qty"));
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));

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
		
		request.setAttribute("m", m);
		request.setAttribute("c", c);
		System.out.println(m);
		System.out.println(c);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
	    HttpSession session = request.getSession();
    	
    	RequestDispatcher dis = request.getRequestDispatcher("/cart/directordercart.jsp");
		dis.forward(request, response);
		
	    //주문자 정보
	    String id = (String)session.getAttribute("id");
	    Member m = new Member();
	    MemberDAO mdao = new MemberDAO();
	    m = mdao.oneMember(id);
	    
	    //아이템 정보
		int qty = Integer.parseInt(request.getParameter("qty"));
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));

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
		
		request.setAttribute("m", m);
		request.setAttribute("c", c);
		System.out.println(m);
		System.out.println(c);
	}
}

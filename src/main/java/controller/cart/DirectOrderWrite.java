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
import dao.MemberDAO;
import dto.Cart;
import dto.Member;
import dto.Orders;


@WebServlet("/cart/directorderwrite")
public class DirectOrderWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public DirectOrderWrite() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		
		//카트 담기
		Date date = new Date();
		SimpleDateFormat sim = new SimpleDateFormat();
		String signdate = sim.format(date);
		
		String mb_id = request.getParameter("mb_id");
		int it_uid = Integer.parseInt(request.getParameter("it_uid")); 
		
		MemberDAO dao = new MemberDAO();
		Member m = dao.oneMember(mb_id);

		String opt1 = request.getParameter("gloOpt1");
		String opt2 = request.getParameter("gloOpt2");
		String opt = opt1 + " / " + opt2;
		
		Cart ca = new Cart();
		
		ca.setIt_uid(Integer.parseInt(request.getParameter("it_uid")));
		ca.setIt_price(Integer.parseInt(request.getParameter("it_price")));
		ca.setIt_sale(Integer.parseInt(request.getParameter("it_sale")));
		ca.setIt_point(Integer.parseInt(request.getParameter("it_point")));
		ca.setIt_qty(Integer.parseInt(request.getParameter("qty")));
		ca.setCt_status("주문");
		ca.setIt_opt1("opt");
		ca.setCt_date(signdate);
		ca.setMb_id(mb_id);
		
		CartDAO cdao = new CartDAO();
		cdao.insertCart(ca);
		
		//오더 담기
		String ct_uid = request.getParameter("ct_uid");

		int count = Integer.parseInt(request.getParameter("count"));
		
		String pn1 = request.getParameter("pn1");
		String pn2 = request.getParameter("pn2");
		String pn3 = request.getParameter("pn3");
		String pn = pn1+"-"+pn2+"-"+pn3;
		
		ArrayList<Orders> orArr = new ArrayList<Orders>();
		
		for(int i = 0; i <= count; i++) {
			Orders or = new Orders();
			if(request.getParameter("mb_id["+i+"]") == null) {
				break;
			}else {
				or.setMb_id(request.getParameter("mb_id["+i+"]"));
			}
			
			or.setIt_uid(request.getParameter("it_uid["+i+"]"));
			or.setIt_price(request.getParameter("it_price["+i+"]"));
			or.setIt_point(request.getParameter("it_point["+i+"]"));
			or.setIt_qty(request.getParameter("it_qty["+i+"]"));
			or.setCt_status("주문");
			or.setIt_opt1(request.getParameter("it_opt1["+i+"]"));
			or.setPn(pn);
			or.setOr_date(signdate);
			or.setZc(request.getParameter("zc"));
			or.setZc1(request.getParameter("zc1"));
			or.setZc2(request.getParameter("zc2"));
			or.setZc3(request.getParameter("zc3"));
			or.setZc4(request.getParameter("zc4"));
			or.setName(request.getParameter("name"));
			or.setOr_opt(request.getParameter("or_opt"));
			or.setOd_id((String)session.getAttribute("cart"));
			
			orArr.add(or);
		}
		cdao.insertOrders(orArr, count);
		
		//status 변경
		String[] ct_uids = new String[count]; // 배열 초기화
		count = Integer.parseInt(request.getParameter("count")); // count 초기화
		
		for(int i = 0; i < count; i++) { // 반복문 수정
		    Cart cart = new Cart();
		    ct_uids[i] = request.getParameter("ct_uid[" + i + "]"); // 배열에 값 할당
		}
		cdao.statusChange(ct_uids,count);
		cdao.qtyUpdate(ct_uids,count);
		
		//적립금 변경
		Member mem = new Member();
		count = Integer.parseInt(request.getParameter("count")); // count 초기화
		String[] points = new String[count]; // 배열 초기화
		int totalPoints = 0; // 총 적립금 초기화
		for(int i = 0; i < count; i++) { // 반복문 수정
		    points[i] = request.getParameter("it_point[" + i + "]"); // 배열에 값 할당
		    totalPoints += Integer.parseInt(points[i]); // 적립금 누적
		}
		cdao.setPoint(mb_id, totalPoints);
		
		RequestDispatcher dis = request.getRequestDispatcher("orderwrite.jsp");
		dis.forward(request, response);
	}
}

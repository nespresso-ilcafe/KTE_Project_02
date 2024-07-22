package controller.cart;

import java.io.IOException;
import java.lang.reflect.Array;
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
import dto.Cart;
import dto.Member;
import dto.Orders;


@WebServlet("/cart/orderwrite")
public class OrderWrite extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OrderWrite() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		RequestDispatcher dis = request.getRequestDispatcher("orderwrite.jsp");
		dis.forward(request, response);
		
		request.setCharacterEncoding("utf-8");
		String ct_uid = request.getParameter("ct_uid");
		HttpSession session = request.getSession();
		
		CartDAO dao = new CartDAO();
		
		Date date = new Date();
		SimpleDateFormat sim = new SimpleDateFormat("yyyyMMdd");
		String or_date = sim.format(date);

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
			or.setOr_date(or_date);
			or.setZc(request.getParameter("zc"));
			or.setZc1(request.getParameter("zc1"));
			or.setZc2(request.getParameter("zc2"));
			or.setZc3(request.getParameter("zc3"));
			or.setZc4(request.getParameter("zc4"));
			or.setName(request.getParameter("name"));
			or.setOr_opt(request.getParameter("or_opt"));
			or.setOd_id(request.getParameter("od_id"));
			orArr.add(or);
		}
		dao.insertOrders(orArr, count);
		
		//status 변경
		String[] ct_uids = new String[count]; // 배열 초기화
		count = Integer.parseInt(request.getParameter("count")); // count 초기화
		
		for(int i = 0; i < count; i++) { // 반복문 수정
		    Cart ca = new Cart();
		    ct_uids[i] = request.getParameter("ct_uid[" + i + "]"); // 배열에 값 할당
		}
		dao.statusChange(ct_uids,count);
		dao.qtyUpdate(ct_uids,count);
		
		//적립금 변경
		Member m = new Member();
		count = Integer.parseInt(request.getParameter("count")); // count 초기화
		String mb_id = (String)session.getAttribute("id");
		String[] points = new String[count]; // 배열 초기화
		int totalPoints = 0; // 총 적립금 초기화
		for(int i = 0; i < count; i++) { // 반복문 수정
		    points[i] = request.getParameter("it_point[" + i + "]"); // 배열에 값 할당
		    totalPoints += Integer.parseInt(points[i]); // 적립금 누적
		}
		dao.setPoint(mb_id, totalPoints);
	}
}

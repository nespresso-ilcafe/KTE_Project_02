package controller.Item;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;
import dto.Category;
import dto.Item;
import dto.ItemQna;


@WebServlet("/item/iqAll")
public class IqAll extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public IqAll() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//////////상품 관련 
		ItemDAO dao = new ItemDAO();
		//아이템 불러오기
		int it_uid = Integer.parseInt(request.getParameter("it_uid"));
		Item it = dao.oneItem(it_uid);
		request.setAttribute("it", it);
		
		String field = request.getParameter("field");
		String search = request.getParameter("search");
		
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
		
		RequestDispatcher dis = request.getRequestDispatcher("iqAll.jsp");
		dis.forward(request, response);
	}
}

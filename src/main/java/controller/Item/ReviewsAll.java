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
import dto.Reviews;


@WebServlet("/item/reviews")
public class ReviewsAll extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ReviewsAll() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		int pageSize = 10;
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
		
		ArrayList<Reviews> rv = dao.getAllReviews(startRow, endRow, it_uid, field, search);
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
		
		RequestDispatcher dis = request.getRequestDispatcher("reviewsAll.jsp");
		dis.forward(request, response);
	}
}

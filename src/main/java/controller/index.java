package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BannerDAO;
import dao.ItemDAO;
import dto.Banner;
import dto.Category;
import dto.Item;

@WebServlet("")
public class index extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public index() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int pageSize = 50;
		int pageNum = 1;
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		ItemDAO dao = new ItemDAO();

		String field = request.getParameter("field");
		String search = request.getParameter("search");

		int count = dao.getAllcount(field, search);
		int number = count - (pageNum - 1) * pageSize;
		int startRow = (pageNum - 1) * pageSize;
		int endRow = pageSize;

		ArrayList<Item> v = dao.getAllMember(startRow, endRow, field, search);

		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("field", field);
		request.setAttribute("search", search);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("number", number);
		
		ArrayList<Category> ca = dao.getCategory(field, search);
		request.setAttribute("ca", ca);
		
		//배너영역
		BannerDAO bdao = new BannerDAO();
		
		ArrayList<Banner> b = bdao.getAllBanner(0,100);
		
		request.setAttribute("b", b);
		
		RequestDispatcher dis = request.getRequestDispatcher("index.jsp");
		dis.forward(request, response);

	}

}

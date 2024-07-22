package controller.Item;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.ItemDAO;
import dto.Category;
import dto.Item;

@WebServlet("/item/list")
public class ItemList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ItemList() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cate1 = request.getParameter("category1");
		String cate2 = request.getParameter("category2");
		request.setAttribute("cate1", cate1);
		request.setAttribute("cate2", cate2);

		int pageSize = 12;
		int pageNum = 1;
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		ItemDAO dao = new ItemDAO();

		String field = request.getParameter("field");
		String search = request.getParameter("search");

		int count = dao.getCateCount(field, search, cate1);
		int number = count - (pageNum - 1) * pageSize;
		int startRow = (pageNum - 1) * pageSize;
		int endRow = pageSize;

		ArrayList<Item> v = dao.getAllItem(startRow, endRow, field, search, cate1);

		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("field", field);
		request.setAttribute("search", search);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("number", number);

		ArrayList<Category> ca = dao.getCategory(field, search);
		request.setAttribute("ca", ca);
		
		RequestDispatcher dis = request.getRequestDispatcher("/item/itemlist.jsp");
		dis.forward(request, response);
	}
}

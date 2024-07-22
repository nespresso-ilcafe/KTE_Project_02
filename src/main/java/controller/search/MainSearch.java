package controller.search;

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

@WebServlet("/mainsearch")
public class MainSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MainSearch() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		int pageSize = 4;
		int pageNum = 1;
		if (request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}

		ItemDAO dao = new ItemDAO();

		String field = request.getParameter("field");
		String search = request.getParameter("search");

		int count = dao.getCateCount1(search);
		
		int number = count - (pageNum - 1) * pageSize;
		int startRow = (pageNum - 1) * pageSize;
		int endRow = pageSize;

		ArrayList<Item> v = dao.getAllItem1(startRow, endRow, search);

		request.setAttribute("v1", v);
		request.setAttribute("count", count);
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

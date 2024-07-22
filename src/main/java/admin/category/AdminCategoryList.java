package admin.category;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CategoryDAO;
import dto.Category;


@WebServlet("/admin/category/list")
public class AdminCategoryList extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
    public AdminCategoryList() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageSize = 10;
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		CategoryDAO dao = new CategoryDAO();
		
		String field = request.getParameter("field");
		String search = request.getParameter("search");
		
		int count = dao.getAllcount(field,search);
		
		int number = count - (pageNum-1) * pageSize;
		
		int startRow = (pageNum-1) * pageSize;
		int endRow = pageSize;
		
		ArrayList<Category> v = dao.getAllMember(startRow,endRow,field,search);
		
		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("number", number);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("pageNum", pageNum);
		
		request.setAttribute("field", field);
		request.setAttribute("search", search);
		
		RequestDispatcher dis = request.getRequestDispatcher("/admin/category/list.jsp");
		dis.forward(request, response);
	}
}

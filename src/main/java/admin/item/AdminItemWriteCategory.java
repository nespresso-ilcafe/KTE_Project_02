package admin.item;

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


@WebServlet("/admin/item/category_ok")
public class AdminItemWriteCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AdminItemWriteCategory() {
        super();
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String ca_id = request.getParameter("ca_id");
		
		ItemDAO dao = new ItemDAO();
		
		ArrayList<Category> v = dao.getCategory2(ca_id);

		request.setAttribute("v", v);

		RequestDispatcher dis = request.getRequestDispatcher("/admin/item/cate2.jsp");
		dis.forward(request, response);
		
	}

}

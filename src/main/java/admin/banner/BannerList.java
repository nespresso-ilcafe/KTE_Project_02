package admin.banner;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.BannerDAO;
import dto.Banner;

@WebServlet("/admin/banner/bannerlist")
public class BannerList extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public BannerList() {
        super();

    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int pageSize =10;
		
		int pageNum = 1;
		if(request.getParameter("pageNum") != null) {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		}
		
		BannerDAO dao = new BannerDAO();
		
		int count = dao.getAllcount();
				
		int number = count - (pageNum - 1) * pageSize;
		
		int startRow = (pageNum - 1) * pageSize;
		int endRow = pageSize;
		
		ArrayList<Banner> v = dao.getAllBanner(startRow, endRow);
		
		request.setAttribute("v", v);
		request.setAttribute("count", count);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("pageSize", pageSize);
		request.setAttribute("number", number);
		
		RequestDispatcher dis = request.getRequestDispatcher("/admin/banner/bannerlist.jsp");
		dis.forward(request, response);
	}

}

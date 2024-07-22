package controller.wish;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.WishDAO;


@WebServlet("/wish/wishdelete")
public class WishDelete extends HttpServlet {
   private static final long serialVersionUID = 1L;

    public WishDelete() {
        super();
    }

   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      int uid =Integer.parseInt(request.getParameter("uid"));
      WishDAO dao = new WishDAO();
      dao.oneDelete(uid);
      
      response.setContentType("text/html; charset=utf-8");
      PrintWriter out = response.getWriter();
      
      out.print("<script>");
      out.print("alert('찜하기에서 삭제하였습니다.');");
      out.print("location.href='wishlist';");
      out.print("</script>");
   }
}
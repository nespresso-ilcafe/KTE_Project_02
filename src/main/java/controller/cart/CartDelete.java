package controller.cart;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;

@WebServlet("/cart/cartdelete")
public class CartDelete extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public CartDelete() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ct_uid = request.getParameter("ct_uid");
        CartDAO dao = new CartDAO();
        dao.oneDelete(ct_uid);

        response.setContentType("text/html; charset=utf-8");
        PrintWriter out = response.getWriter();

        out.print("<script>");
        out.print("alert('장바구니에서 삭제하였습니다.');");
        out.print("location.href='cartlist';");
        out.print("</script>");
    }
}

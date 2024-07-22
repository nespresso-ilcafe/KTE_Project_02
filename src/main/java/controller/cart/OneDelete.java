package controller.cart;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.CartDAO;


@WebServlet("/cart/onedelete")
public class OneDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public OneDelete() {
        super();
    }
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] ct_uids = request.getParameterValues("ct_uids[]"); // 여러 값들을 배열로 받음

        if (ct_uids != null) {
            CartDAO dao = new CartDAO();
            for (String ct_uid : ct_uids) {
                dao.oneDelete(ct_uid); // 각 ct_uid에 대해 삭제 수행
            }
        }
        response.sendRedirect("/cart/cartlist");
    }
}

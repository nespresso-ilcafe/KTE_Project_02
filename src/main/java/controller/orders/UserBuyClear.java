package controller.orders;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import dao.UserOrderDAO;

@WebServlet("/orders/buyclear")
public class UserBuyClear extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public UserBuyClear() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String mb_id = request.getParameter("mb_id");
        String od_id = request.getParameter("od_id");
        String or_uid = request.getParameter("or_uid");
        UserOrderDAO dao = new UserOrderDAO();
        dao.buyClear(or_uid);
        response.sendRedirect("/orders/userorderview?mb_id=" + mb_id + "&od_id=" + od_id);
    }
}

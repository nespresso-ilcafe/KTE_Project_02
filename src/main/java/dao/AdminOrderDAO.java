package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Member;
import dto.Orders;

public class AdminOrderDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();

    //주문목록
    public ArrayList<Orders> getOdList(int startRow, int endRow, String field, String search) {
        d.getCon();
        ArrayList<Orders> orArr = new ArrayList<Orders>();
        try {

            String sql = "SELECT od_id,ct_status,mb_id,name, SUM(it_price) AS total_price FROM orders GROUP BY od_id ORDER BY or_uid DESC LIMIT ?, ?";

            if (search != null && !search.equals("")) {
                sql = "SELECT od_id,ct_status,mb_id,name, SUM(it_price) AS total_price FROM orders WHERE " + field + " LIKE '%" + search + "%' GROUP BY od_id ORDER BY or_uid DESC LIMIT ?, ?";
            }
            pstmt = d.con.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);
            rs = pstmt.executeQuery();

            while(rs.next()){
                Orders or = new Orders();

                or.setOd_id(rs.getString("od_id"));
                or.setCt_status(rs.getString("ct_status"));
                or.setMb_id(rs.getString("mb_id"));
                or.setName(rs.getString("name"));
                or.setTotal_price(rs.getInt("total_price"));

                orArr.add(or);
            }
            rs.close();
            pstmt.close();
            d.con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orArr;
    }

    //뷰페이지
    public ArrayList<Orders> getAllOrder(String od_id){
        d.getCon();
        ArrayList<Orders> orArr = new ArrayList<Orders>();
        try {

            String sql = "SELECT orders.*, (SELECT category2 FROM item WHERE item.it_uid = orders.it_uid) AS cate2, (SELECT it_name FROM item WHERE item.it_uid = orders.it_uid) AS it_name FROM orders WHERE od_id = ?";
            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, od_id);
            rs = pstmt.executeQuery();

            while(rs.next()){
                Orders or = new Orders();

                or.setCt_status(rs.getString("ct_status"));
                or.setIt_opt1(rs.getString("it_opt1"));
                or.setIt_point(rs.getString("it_point"));
                or.setIt_price(rs.getString("it_price"));
                or.setIt_qty(rs.getString("it_qty"));
                or.setIt_uid(rs.getString("it_uid"));
                or.setMb_id(rs.getString("mb_id"));
                or.setName(rs.getString("name"));
                or.setOd_id(rs.getString("od_id"));
                or.setOr_date(rs.getString("or_date"));
                or.setOr_uid(rs.getString("or_uid"));
                or.setPn(rs.getString("pn"));
                or.setZc(rs.getString("zc"));
                or.setZc1(rs.getString("zc1"));
                or.setZc2(rs.getString("zc2"));
                or.setZc3(rs.getString("zc3"));
                or.setZc4(rs.getString("zc4"));
                or.setCate2(rs.getString("cate2"));
                or.setIt_name(rs.getString("it_name"));

                orArr.add(or);
            }
            rs.close();
            pstmt.close();
            d.con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return orArr;
    }

    //주문상태 총개수
    public int getAllcount(String field,String search) {
        d.getCon();

        int count = 0;
        try {
            String sql = "SELECT COUNT(DISTINCT od_id) AS unique_od_count FROM orders";

            if(search != null && !search.equals("")) {
                sql = "SELECT COUNT(DISTINCT od_id) AS unique_od_count FROM orders "+field+" like '%"+search+"%'";
            }

            pstmt=d.con.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }

            rs.close();
            pstmt.close();
            d.con.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

    //배송시작 변경
    public void orderSend(String od_id) {
        d.getCon();
        try {
            String sql = "UPDATE cart JOIN orders ON orders.it_uid = cart.it_uid SET cart.ct_status = '배송', orders.ct_status = '배송' WHERE orders.od_id = ?";

            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, od_id);
            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    //배송완료 변경
    public void orderClear(String od_id) {
        d.getCon();
        try {
            String sql = "UPDATE cart JOIN orders ON orders.it_uid = cart.it_uid SET cart.ct_status = '완료', orders.ct_status = '완료' WHERE orders.od_id = ?";

            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, od_id);
            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

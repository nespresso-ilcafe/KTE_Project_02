package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Item;
import dto.Orders;
import dto.OrdersItem;

public class UserOrderDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();
    
    // 주문 목록
    public ArrayList<Orders> getOrderList(String id, int startRow, int endRow, String field, String search) {
        d.getCon();
        ArrayList<Orders> orArr = new ArrayList<Orders>();
        try {
            String sql = "SELECT o.or_date, o.od_id, o.ct_status, o.mb_id, o.name, SUM(o.it_price) AS total_price, i.file1_thumb FROM orders o INNER JOIN item i ON o.it_uid = i.it_uid WHERE o.mb_id = ? GROUP BY o.od_id ORDER BY o.or_uid DESC LIMIT ?, ?";

            if (search != null && !search.equals("")) {
                sql = "SELECT o.or_date, o.od_id, o.ct_status, o.mb_id, o.name, SUM(o.it_price) AS total_price, i.file1_thumb FROM orders o INNER JOIN item i ON o.it_uid = i.it_uid WHERE o.mb_id = ? AND " + field + " LIKE '%" + search + "%' GROUP BY o.od_id ORDER BY o.or_uid DESC LIMIT ?, ?";
            }
            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setInt(2, startRow);
            pstmt.setInt(3, endRow);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Orders or = new Orders();
                
                or.setOd_id(rs.getString("od_id"));
                or.setCt_status(rs.getString("ct_status"));
                or.setMb_id(rs.getString("mb_id"));
                or.setName(rs.getString("name"));
                or.setTotal_price(rs.getInt("total_price"));
                or.setFile1_thumb(rs.getString("file1_thumb"));
                or.setOr_date(rs.getString("or_date"));
                
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
    
    // 구매 내역 상세
    public ArrayList<OrdersItem> getOneOrder(String od_id){
        d.getCon();
        ArrayList<OrdersItem> orArr = new ArrayList<OrdersItem>();
        try {
            String sql = "SELECT * FROM orders RIGHT JOIN item ON orders.it_uid = item.it_uid WHERE orders.od_id = ?";
            
            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, od_id);
            
            rs = pstmt.executeQuery();
            while(rs.next()) {
                OrdersItem oi = new OrdersItem();
                
                oi.setCt_status(rs.getString("ct_status"));
                oi.setIt_opt1(rs.getString("it_opt1"));
                oi.setIt_point(rs.getString("it_point"));
                oi.setIt_price(rs.getString("it_price"));
                oi.setIt_qty(rs.getString("it_qty"));
                oi.setIt_uid(rs.getString("it_uid"));
                oi.setMb_id(rs.getString("mb_id"));
                oi.setName(rs.getString("name"));
                oi.setOd_id(rs.getString("od_id"));
                oi.setOr_date(rs.getString("or_date"));
                oi.setOr_opt(rs.getString("or_opt"));
                oi.setOr_uid(rs.getString("or_uid"));
                oi.setPn(rs.getString("pn"));
                oi.setZc(rs.getString("zc"));
                oi.setZc1(rs.getString("zc1"));
                oi.setZc2(rs.getString("zc2"));
                oi.setZc3(rs.getString("zc3"));
                oi.setZc4(rs.getString("zc4"));
                oi.setIt_name(rs.getString("it_name"));
                oi.setFile1_thumb(rs.getString("file1_thumb"));
                
                orArr.add(oi);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orArr;
    }
    
    // 썸네일 가져오기
    public ArrayList<Orders> getThumbNail() {
        d.getCon();
        ArrayList<Orders> orArr = new ArrayList<Orders>();
        try {
            String sql = "SELECT i.file1_thumb FROM orders o INNER JOIN item i ON o.it_uid = i.it_uid";
            pstmt = d.con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Orders or = new Orders();
                or.setFile1_thumb(rs.getString("file1_thumb"));
                
                orArr.add(or);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orArr;
    }
    
    // 주문 총액
    public ArrayList<Orders> getTotalPrice() {
        d.getCon();
        ArrayList<Orders> orArr = new ArrayList<Orders>();
        try {
            String sql = "select od_id, sum(it_price) as total_price from orders group by od_id";
            pstmt = d.con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Orders or = new Orders();
                or.setTotal_price(rs.getInt("total_price"));
                
                orArr.add(or);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orArr;
    }
    
    // 주문 총 개수
    public int getAllcount(String id, String field, String search) {
        d.getCon();
        
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS group_count FROM (SELECT * FROM orders WHERE mb_id = ? AND ct_status <> '준비' GROUP BY od_id) AS grouped_orders";
            
            if(search != null && !search.equals("")) {
                sql = "SELECT COUNT(*) AS group_count FROM (SELECT * FROM orders WHERE mb_id = ? AND ct_status <> '준비' AND " + field + " LIKE '%" + search + "%' GROUP BY od_id) AS grouped_orders";
            }
            
            pstmt=d.con.prepareStatement(sql);
            pstmt.setString(1, id);
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

    // 구매 확정
    public void buyClear(String or_uid) {
        d.getCon();
        try {
            String sql = "update orders set ct_status='구매확정' where or_uid=? ";
            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, or_uid);
            pstmt.executeUpdate();
            
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Cart;
import dto.Wish;

public class WishDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();
   
    // wish list 목록
    public ArrayList<Wish> getAllWish(String id) {
        d.getCon();
           
        ArrayList<Wish> v = new ArrayList<>();
           
        try {
            String sql = "SELECT *, (SELECT file1_thumb FROM item WHERE item.it_uid=wish.it_uid) AS file1_thumb, (SELECT it_qty FROM item WHERE item.it_uid=wish.it_uid) AS it_qty1 FROM wish WHERE user_id=?";
                  
            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, id);
               
            rs = pstmt.executeQuery();
               
            while(rs.next()) {
                Wish w = new Wish();
                   
                w.setUid(rs.getInt("uid"));
                w.setUser_id(rs.getString("user_id"));
                w.setIt_uid(rs.getInt("it_uid"));
                w.setIt_name(rs.getString("it_name"));
                w.setIt_price(rs.getInt("it_price"));
                w.setQty(rs.getInt("qty"));
                w.setIt_option(rs.getString("it_option"));
                w.setIt_point(rs.getInt("it_point"));
                w.setFile1_thumb(rs.getString("file1_thumb"));
                w.setIt_qty1(rs.getInt("it_qty1"));
                    
                v.add(w);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return v;
    }
    
    // 삭제
    public void oneDelete(int uid) {
        d.getCon();
           
        try {
            String sql = "delete from wish where uid=?";
               
            pstmt=d.con.prepareStatement(sql);
            pstmt.setInt(1, uid);
               
            pstmt.executeUpdate();
               
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 전체 찜 수
    public int getAllcount(String id) {
        d.getCon();

        int count = 0;

        try {
            String sql = "select count(*) from wish where user_id=?";
               
            pstmt=d.con.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();

            if(rs.next()) {
                count = rs.getInt(1);
            }      
            
            rs.close();
            pstmt.close();
            d.con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return count;
    }
    
    // 상품 > 찜하기
    public void oneInsert(Wish w) {
        d.getCon();
           
        try {
            String sql = "insert into wish values (null,?,?,?,?,?,?,?,?)";
               
            pstmt=d.con.prepareStatement(sql);
               
            pstmt.setString(1, w.getUser_id());
            pstmt.setInt(2, w.getIt_uid());
            pstmt.setString(3, w.getIt_name());
            pstmt.setInt(4, w.getIt_price());
            pstmt.setInt(5, w.getQty());
            pstmt.setString(6, w.getIt_option());
            pstmt.setInt(7, w.getIt_point());
            pstmt.setInt(8, w.getIt_sale());
               
            pstmt.executeUpdate();
               
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // wish > cart
    public void oneInsertCart(Cart c) {
        d.getCon();
           
        try {
            String sql = "insert into cart values (null,?,?,?,?,?,'준비',?,?,?)";
               
            pstmt=d.con.prepareStatement(sql);
               
            pstmt.setString(1, c.getMb_id());
            pstmt.setInt(2, c.getIt_uid());
            pstmt.setInt(3, c.getIt_price());
            pstmt.setInt(4, c.getIt_point());
            pstmt.setInt(5, c.getIt_qty());
            pstmt.setString(6, c.getCt_date());
            pstmt.setString(7, c.getIt_opt1());
            pstmt.setInt(8, c.getIt_sale());
               
            pstmt.executeUpdate();
               
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }  
}

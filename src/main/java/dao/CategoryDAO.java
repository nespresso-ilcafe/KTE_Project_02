package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Category;

public class CategoryDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;
   
    DAO d = new DAO();
   
    //총 게시물 수
    public int getAllcount(String field, String search) {
        d.getCon();
      
        int count = 0;
        try {
            String sql;
            if(search != null && !search.equals("")) {
                sql = "select count(*) from category where "+field+" like '%"+search+"%'";
            }else {
                sql = "select count(*) from category";
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
   
    //목록
    public ArrayList<Category> getAllMember(int startRow,int endRow,String field,String search){
        d.getCon();
      
        ArrayList<Category> v = new ArrayList<Category>();
        try {
            String sql = "";
            if(search != null && !search.equals("")) {
                if (field.equals("ca_id")) {
                    sql = "select * from category where "+field+" like '"+search+"%' order by ca_id asc limit ?,?";
                } else {
                    sql = "select * from category where "+field+" like '%"+search+"%' order by ca_id asc limit ?,?";
                }
            }else {
                sql = "select * from category order by ca_id asc limit ?,?";   
            }
            pstmt=d.con.prepareStatement(sql);
            pstmt.setInt(1, startRow);
            pstmt.setInt(2, endRow);
         
            rs=pstmt.executeQuery();
         
            while(rs.next()) {
                Category c = new Category();
            
                c.setCa_id(rs.getString("ca_id"));
                c.setCa_name(rs.getString("ca_name"));
                c.setCa_use(rs.getString("ca_use"));
            
                v.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (d.con != null) d.con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return v;
    }
   
    //등록
    public void insertCategory(Category c) {
        d.getCon();
      
        try {
            String sql = "insert into category values(?,?,?)";
         
            pstmt=d.con.prepareStatement(sql);
         
            pstmt.setString(1, c.getCa_id());
            pstmt.setString(2, c.getCa_name());
            pstmt.setString(3, c.getCa_use());
         
            pstmt.executeUpdate();
         
            pstmt.close();
            d.con.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
   
    //수정
    public void updateCategory(Category c) {
        d.getCon();
      
        try {
            String sql = "update category set ca_name=?, ca_use=? where ca_id=?";
         
            pstmt=d.con.prepareStatement(sql);
         
            pstmt.setString(1, c.getCa_name());
            pstmt.setString(2, c.getCa_use());
            pstmt.setString(3, c.getCa_id());
         
            pstmt.executeUpdate();
         
            pstmt.close();
            d.con.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
   
    //삭제
    public void oneDelete(String ca_id) {
        d.getCon();
      
        try {
            String sql = "delete from category where ca_id=?";
         
            pstmt=d.con.prepareStatement(sql);
         
            pstmt.setString(1, ca_id);
         
            pstmt.executeUpdate();
         
            pstmt.close();
            d.con.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
}

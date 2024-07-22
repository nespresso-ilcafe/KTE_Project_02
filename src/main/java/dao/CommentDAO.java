package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import dto.Comment;

public class CommentDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;
	
    DAO d = new DAO();
	
    //댓글입력
    public Comment addComment(Comment c) {
        d.getCon();
		
        try {
            String sql = "insert into comment values(null,?,?,?,?,?)";
			
            pstmt=d.con.prepareStatement(sql);
			
            pstmt.setString(1, c.getTb_table());
            pstmt.setInt(2, c.getTb_uid());
            pstmt.setString(3, c.getTb_id());
            pstmt.setString(4, c.getTb_comment());
            pstmt.setString(5, c.getTb_date());
			
            pstmt.executeUpdate();
			
            pstmt.close();
            d.con.close();
			
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }
   
    //총 댓글 수
    public int getAllcount() {
        d.getCon();
        int count=0;
        try {
            String sql = "select count(*) from comment";
            
            pstmt=d.con.prepareStatement(sql);
            rs=pstmt.executeQuery();
            
            if(rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
   
    //댓글 목록
    public ArrayList<Comment> getAllComment(int uid) {
        d.getCon();
        
        ArrayList<Comment> v = new ArrayList<>();
        
        try {
            String sql = "SELECT * FROM comment WHERE tb_uid=? ORDER BY tb_date DESC";
               
            pstmt = d.con.prepareStatement(sql);
            
            pstmt.setInt(1, uid);
            
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                Comment c = new Comment();
                
                c.setUid(rs.getInt("uid"));
                c.setTb_table(rs.getString("tb_table"));
                c.setTb_uid(rs.getInt("tb_uid"));
                c.setTb_id(rs.getString("tb_id"));
                c.setTb_comment(rs.getString("tb_comment"));
                c.setTb_date(rs.getString("tb_date"));
                 
                v.add(c);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return v;
    }
   
    //삭제
    public void oneDelete(int uid) {
        d.getCon();
        
        try {
            String sql = "delete from comment where uid=?";
            
            pstmt=d.con.prepareStatement(sql);
            
            pstmt.setInt(1, uid);
            
            pstmt.executeUpdate();
            
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;

import dto.Member;

public class MemberDAO {
    Statement stmt;
    PreparedStatement pstmt;
    ResultSet rs;

    DAO d = new DAO();

    // 회원가입
    public void MemberInsert(Member m) {
        d.getCon();

        try {
            String sql= "insert into member values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 1000)";

            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, m.getId());
            pstmt.setString(2, m.getPass());
            pstmt.setString(3, m.getName());
            pstmt.setString(4, m.getBirth());
            pstmt.setString(5, m.getPn());
            pstmt.setString(6, m.getEmail());
            pstmt.setString(7, m.getZc());
            pstmt.setString(8, m.getZc1());
            pstmt.setString(9, m.getZc2());
            pstmt.setString(10, m.getZc3());
            pstmt.setString(11, m.getZc4());
            pstmt.setString(12, m.getSigndate());
            pstmt.setString(13, m.getConnecttype());
            pstmt.setString(14, m.getLevel());
            pstmt.setString(15, m.getStatus());
            pstmt.setString(16, m.getGender());

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 아이디 확인
    public int loginOk(String id) {
        d.getCon();
        
        int num = 0;
        try {
            String sql = "select count(*) from member where id =?";
            pstmt = d.con.prepareStatement(sql);
              
            pstmt.setString(1, id);
              
            rs = pstmt.executeQuery();
            
            // 로그인 처리 
            if(rs.next()) {
                num = rs.getInt(1);
            }
            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return num;
    }
    
    // 로그인 
    public Member MemberLogin(String id, String pass) {
        d.getCon();
        Member m = new Member();
        try {
            String sql = "select * from member where id=? and pass=?";
            
            pstmt = d.con.prepareStatement(sql);
            
            pstmt.setString(1, id);
            pstmt.setString(2, pass);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                m.setId(rs.getString("id"));
                m.setLevel(rs.getString("level"));
                m.setConnecttype(rs.getString("connecttype"));
                m.setStatus(rs.getString("status"));
                m.setName(rs.getString("name"));
            }

            rs.close();
            pstmt.close();
            d.con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return m;
    }
    
    // 회원정보 확인 - 회원용
    public Member oneMember(String id) {
        d.getCon();

        Member m = new Member();
        
        try {
            String sql = "select * from member where id =?";

            pstmt = d.con.prepareStatement(sql);
            pstmt.setString(1, id);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                m.setId(rs.getString("id"));
                m.setPass(rs.getString("pass"));
                m.setName(rs.getString("name"));
                m.setBirth(rs.getString("birth"));
                m.setPn(rs.getString("pn"));
                m.setEmail(rs.getString("email"));
                m.setZc(rs.getString("zc"));
                m.setZc1(rs.getString("zc1"));
                m.setZc2(rs.getString("zc2"));
                m.setZc3(rs.getString("zc3"));
                m.setZc4(rs.getString("zc4"));
                m.setSigndate(rs.getString("signdate"));
                m.setConnecttype(rs.getString("connecttype"));
                m.setLevel(rs.getString("level"));
                m.setStatus(rs.getString("status"));
                m.setGender(rs.getString("gender"));
                m.setPoint(rs.getInt("point"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return m;
    }

    // 회원수정
    public void updateMember(Member m) {
        d.getCon();
        
        String str="";
        if(m.getPass() != null && !m.getPass().equals("")) {
            str=",pass='"+m.getPass()+"'";
        }
        
        try {
            String sql = "update member set name=?,birth=?,pn=?,email=?,zc=?,zc1=?,zc2=?,zc3=?,zc4=?,gender=?"+str+" where id=?";

            pstmt=d.con.prepareStatement(sql);
            
            pstmt.setString(1, m.getName());
            pstmt.setString(2, m.getBirth());
            pstmt.setString(3, m.getPn());
            pstmt.setString(4, m.getEmail());
            pstmt.setString(5, m.getZc());
            pstmt.setString(6, m.getZc1());
            pstmt.setString(7, m.getZc2());
            pstmt.setString(8, m.getZc3());
            pstmt.setString(9, m.getZc4());
            pstmt.setString(10, m.getGender());
            pstmt.setString(11, m.getId());
            
            pstmt.executeUpdate();
            
            pstmt.close();
            d.con.close();
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // 회원가입 - 카카오
    public void insertMemberApi(String id, String signdate) {
        d.getCon();
        
        try {
            String sql = "insert into member (id,name,email,connecttype,level,status,signdate ) values (?, ?, ?, ?, ?, ?, ?)";
            pstmt = d.con.prepareStatement(sql);

            pstmt.setString(1, id);
            pstmt.setString(2, "카카오로그인");
            pstmt.setString(3, id);
            pstmt.setString(4, "카카오");
            pstmt.setString(5, "1");
            pstmt.setString(6, "정상");
            pstmt.setString(7, signdate);

            pstmt.executeUpdate();

            pstmt.close();
            d.con.close();
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    // 회원가입 - 네이버
    public void insertMemberApi2(String id, String signdate) {
       d.getCon(); // 데이터베이스 연결

       try {
          String sql = "insert into member (id,name,email,connecttype,level,status,signdate ) values (?, ?, ?, ?, ?, ?, ?)";
          pstmt = d.con.prepareStatement(sql);

          pstmt.setString(1, id);
          pstmt.setString(2, "네이버로그인");
          pstmt.setString(3, id);
          pstmt.setString(4, "네이버");
          pstmt.setString(5, "1");
          pstmt.setString(6, "정상");
          pstmt.setString(7, signdate);

          pstmt.executeUpdate();

          pstmt.close();
          d.con.close();
       }catch(Exception e) {
          e.printStackTrace();
       }
    }
}

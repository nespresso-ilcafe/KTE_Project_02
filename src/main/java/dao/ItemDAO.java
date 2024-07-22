package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import dto.Cart;
import dto.CartMember;
import dto.Category;
import dto.Item;
import dto.ItemQna;
import dto.Member;
import dto.Reviews;

public class ItemDAO {

	Statement stmt;
	PreparedStatement pstmt;
	ResultSet rs;

	DAO d = new DAO();

	// 상품등록
	public void insertItem(Item i) {
		d.getCon();

		try {
			String sql = "insert into item values (null,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = d.con.prepareStatement(sql);

			pstmt.setString(1, i.getCategory1());
			pstmt.setString(2, i.getCategory2());
			pstmt.setString(3, i.getMb_id());
			pstmt.setString(4, i.getIt_name());
			pstmt.setInt(5, i.getIt_sale());
			pstmt.setInt(6, i.getIt_price());
			pstmt.setInt(7, i.getIt_point());
			pstmt.setInt(8, i.getIt_qty());
			pstmt.setString(9, i.getIt_use());
			pstmt.setString(10, i.getIt_date());
			pstmt.setString(11, i.getIt_type1());
			pstmt.setString(12, i.getIt_type2());
			pstmt.setString(13, i.getIt_type3());
			pstmt.setString(14, i.getIt_type4());
			pstmt.setString(15, i.getIt_type5());
			pstmt.setString(16, i.getFile1());
			pstmt.setString(17, i.getFile2());
			pstmt.setString(18, i.getFile3());
			pstmt.setString(19, i.getFile4());
			pstmt.setString(20, i.getFile5());
			pstmt.setString(21, i.getFile1_thumb()); // 썸네일
			pstmt.setString(22, i.getIt_option());

			pstmt.executeUpdate();

			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 총 게시물 수 (인덱스)
	public int getAllcount(String field, String search) {
		d.getCon();

		int count = 0;
		try {
			String sql;
			if (search != null && !search.equals("")) {
				sql = "select count(*) from item where " + field + " like '%" + search + "%'";
			} else {
				sql = "select count(*) from item";
			}
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
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

	
	// 상품 목록 (인덱스)
	public ArrayList<Item> getAllMember(int startRow, int endRow, String field, String search) {
		d.getCon();

		ArrayList<Item> v = new ArrayList<Item>();

		try {
			String sql = "";
			if (search != null && !search.equals("")) {
				sql = "select *,(select ca_name from category where category.ca_id=item.category2 ) as cate2 from item where " + field + " like '%" + search + "%' order by it_uid desc limit ?,? ";
			} else {
				sql = "select *,(select ca_name from category where category.ca_id=item.category2 ) as cate2 from item order by it_uid desc limit ?,?";
			}

			pstmt = d.con.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Item it = new Item();

				it.setCategory1(rs.getString("category1"));
				it.setCategory2(rs.getString("category2"));
				it.setFile1(rs.getString("file1"));
				it.setFile1_thumb(rs.getString("File1_thumb"));
				it.setIt_name(rs.getString("it_name"));
				it.setIt_option(rs.getString("it_option"));
				it.setIt_point(rs.getInt("it_point"));
				it.setIt_price(rs.getInt("it_price"));
				it.setIt_sale(rs.getInt("it_sale"));
				it.setIt_qty(rs.getInt("it_qty"));
				it.setIt_type1(rs.getString("it_type1"));
				it.setIt_type2(rs.getString("it_type2"));
				it.setIt_type3(rs.getString("it_type3"));
				it.setIt_type4(rs.getString("it_type4"));
				it.setIt_type5(rs.getString("it_type5"));
				it.setIt_uid(rs.getInt("it_uid"));
				it.setIt_use(rs.getString("it_use"));
				it.setMb_id(rs.getString("mb_id"));
				it.setCate2_name(rs.getString("cate2"));

				v.add(it);
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return v;
	}
	
//////////////////////////////////////////////////itemlist////////////////////////////////////////////
	// 상품 목록 (상품목록)
	public ArrayList<Item> getAllItem(int startRow, int endRow, String field, String search, String cate1) {
		d.getCon();
		ArrayList<Item> v = new ArrayList<Item>();
		try {
			String sql = "";
			if (search != null && !search.equals("")) {
				sql = "select *,(select avg(rating) from reviews where reviews.it_uid=item.it_uid group by it_uid) as avg_rating from item where category1=? " + field + " like '%" + search + "%' order by it_uid desc limit ?,?";
			} else {
				sql = "select *,(select avg(rating) from reviews where reviews.it_uid=item.it_uid group by it_uid) as avg_rating from item where category1=? order by it_uid desc limit ?,?";
			}

			pstmt = d.con.prepareStatement(sql);

			pstmt.setString(1, cate1);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Item it = new Item();

				it.setCategory1(rs.getString("category1"));
				it.setCategory2(rs.getString("category2"));
				it.setFile1(rs.getString("file1"));
				it.setFile1_thumb(rs.getString("File1_thumb"));
				it.setIt_name(rs.getString("it_name"));
				it.setIt_option(rs.getString("it_option"));
				it.setIt_point(rs.getInt("it_point"));
				it.setIt_price(rs.getInt("it_price"));
				it.setIt_sale(rs.getInt("it_sale"));
				it.setIt_qty(rs.getInt("it_qty"));
				it.setIt_type1(rs.getString("it_type1"));
				it.setIt_type2(rs.getString("it_type2"));
				it.setIt_type3(rs.getString("it_type3"));
				it.setIt_type4(rs.getString("it_type4"));
				it.setIt_type5(rs.getString("it_type5"));
				it.setIt_uid(rs.getInt("it_uid"));
				it.setIt_use(rs.getString("it_use"));
				it.setMb_id(rs.getString("mb_id"));
				it.setAvg_rating(rs.getDouble("avg_rating"));

				v.add(it);
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}
	
	// 총 갯수 (상품목록)
	public int getCateCount(String field, String search, String cate1) {
		d.getCon();

		int count = 0;
		try {
			String sql;
			if (search != null && !search.equals("")) {
				sql = "SELECT COUNT(*) FROM item WHERE category1 = " + cate1 + " AND " + field + " LIKE '%" + search;
			} else {
				sql = "SELECT COUNT(*) FROM item WHERE category1 = " + cate1;
			}
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
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
	
	//테이블 조인 평점 노출
	public double getListRating(int it_uid) {
		d.getCon();
		double ra = 0.0;
		try {
			String sql = "select it_uid, avg(rating) as avg_rating from reviews where it_uid=? group by it_uid;";
			
			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, it_uid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ra = rs.getDouble("avg_rating");
            }
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ra;
	}
	
///////////////////////////////////////////////////itemview////////////////////////////////////////////////
	// 상품 상세보기(카테고리) 페이지
	public Item oneItem(int it_uid) {
		d.getCon();
		Item it = new Item();

		try {
			String sql = "select *,(select ca_name from category where ca_id=item.category2) as cate2_name from item where it_uid=?";

			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, it_uid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				it.setCategory1(rs.getString("category1"));
				it.setCategory2(rs.getString("category2"));
				it.setCate2_name(rs.getString("cate2_name"));
				it.setFile1(rs.getString("file1"));
				it.setFile1_thumb(rs.getString("File1_thumb"));
				it.setFile2(rs.getString("file2"));
				it.setFile3(rs.getString("file3"));
				it.setFile4(rs.getString("file4"));
				it.setFile5(rs.getString("file5"));
				it.setIt_date(rs.getString("it_date"));
				it.setIt_name(rs.getString("it_name"));
				it.setIt_option(rs.getString("it_option"));
				it.setIt_point(rs.getInt("it_point"));
				it.setIt_price(rs.getInt("it_price"));
				it.setIt_qty(rs.getInt("it_qty"));
				it.setIt_sale(rs.getInt("it_sale"));
				it.setIt_type1(rs.getString("it_type1"));
				it.setIt_type2(rs.getString("it_type2"));
				it.setIt_type3(rs.getString("it_type3"));
				it.setIt_type4(rs.getString("it_type4"));
				it.setIt_type5(rs.getString("it_type5"));
				it.setIt_uid(rs.getInt("it_uid"));
				it.setIt_use(rs.getString("it_use"));
				it.setMb_id(rs.getString("mb_id"));
			}

			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return it;
	}

	// 목록
	public ArrayList<Category> getCategory(String field, String search) {
		d.getCon();

		ArrayList<Category> v = new ArrayList<Category>();
		try {
			String sql = "";
			if (search != null && !search.equals("")) {
				sql = "select * from category where " + field + " like '%" + search + "%' order by ca_id";
			} else {
				sql = "select * from category order by ca_id asc";
			}
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				Category c = new Category();

				c.setCa_id(rs.getString("ca_id"));
				c.setCa_name(rs.getString("ca_name"));
				c.setCa_use(rs.getString("ca_use"));

				v.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return v;
	}

	// 카테고리 대분류
	public ArrayList<Category> getTotal() {
		d.getCon();

		ArrayList<Category> v = new ArrayList<Category>();
		try {
			String sql = "select * from category where length(ca_id)=2 and ca_use='Y'";

			pstmt = d.con.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				Category c = new Category();

				c.setCa_id(rs.getString("ca_id"));
				c.setCa_name(rs.getString("ca_name"));

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

	// 카테고리 중분류
	public ArrayList<Category> getCategory2(String ca_id) {
		d.getCon();

		ArrayList<Category> v = new ArrayList<Category>();
		try {
			String sql = "select * from category where left(ca_id,2)=? and length(ca_id)=4 and ca_use='Y'";

			pstmt = d.con.prepareStatement(sql);
			pstmt.setString(1, ca_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Category c = new Category();

				c.setCa_id(rs.getString("ca_id"));
				c.setCa_name(rs.getString("ca_name"));

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


	// 브랜드명 추출
	public Category getMiddle(String ca_id) {
		d.getCon();

		Category ca = new Category();

		try {
			String sql = "select * from category where ca_id=?";

			pstmt = d.con.prepareStatement(sql);

			pstmt.setString(1, ca_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				ca.setCa_id(rs.getString("ca_id"));
				ca.setCa_name(rs.getString("ca_name"));
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ca;
	}

	// 상품수정
	public void updateItem(Item i) {
		d.getCon();

		try {
			String str = "";
			if (i.getFile1() != null && !i.getFile1().equals("")) {
				str = ",file1='" + i.getFile1() + "'";
			}
			String str1 = "";
			if (i.getFile2() != null && !i.getFile2().equals("")) {
				str1 = ",file2='" + i.getFile2() + "'";
			}
			String str2 = "";
			if (i.getFile3() != null && !i.getFile3().equals("")) {
				str2 = ",file3='" + i.getFile3() + "'";
			}
			String str3 = "";
			if (i.getFile4() != null && !i.getFile4().equals("")) {
				str3 = ",file4='" + i.getFile4() + "'";
			}
			String str4 = "";
			if (i.getFile5() != null && !i.getFile5().equals("")) {
				str4 = ",file5='" + i.getFile5() + "'";
			}
			String str5 = "";
			if (i.getFile1_thumb() != null && !i.getFile1_thumb().equals("")) {
				str5 = ",file1_thumb='" + i.getFile1_thumb() + "'";
			}

			String sql = "update item set category1=?,category2=?,mb_id=?,it_name=?,it_sale=?,it_price=?,it_point=?,it_qty=?,it_option=?,it_use=?,it_date=?,it_type1=?,it_type2=?,it_type3=?,it_type4=?,it_type5=?"
					+ str + str1 + str2 + str3 + str4 + str5 + " where it_uid=?";

			pstmt = d.con.prepareStatement(sql);

			pstmt.setString(1, i.getCategory1());
			pstmt.setString(2, i.getCategory2());
			pstmt.setString(3, i.getMb_id());
			pstmt.setString(4, i.getIt_name());
			pstmt.setInt(5, i.getIt_sale());
			pstmt.setInt(6, i.getIt_price());
			pstmt.setInt(7, i.getIt_point());
			pstmt.setInt(8, i.getIt_qty());
			pstmt.setString(9, i.getIt_option());
			pstmt.setString(10, i.getIt_use());
			pstmt.setString(11, i.getIt_date());
			pstmt.setString(12, i.getIt_type1());
			pstmt.setString(13, i.getIt_type2());
			pstmt.setString(14, i.getIt_type3());
			pstmt.setString(15, i.getIt_type4());
			pstmt.setString(16, i.getIt_type5());
			pstmt.setInt(17, i.getIt_uid());

			pstmt.executeUpdate();

			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 삭제
	public void oneDelete(int it_uid) {
		d.getCon();

		try {
			String sql = "delete from item where it_uid=?";

			pstmt = d.con.prepareStatement(sql);

			pstmt.setInt(1, it_uid);

			pstmt.executeUpdate();

			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
////////////////////////////////////////리뷰///////////////////////////////////////////
	// 리뷰 가져오기 - 상품페이지
		public ArrayList<Reviews> getSomeReviews(int it_uid) {
			d.getCon();
			ArrayList<Reviews> r = new ArrayList<Reviews>();

			try {
				String sql = "select * from reviews where it_uid=? order by rv_date desc limit 0,5 ";
				
				pstmt = d.con.prepareStatement(sql);
				pstmt.setInt(1, it_uid);
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					Reviews rv = new Reviews();

					rv.setIt_uid(rs.getInt("it_uid"));
					rv.setMb_id(rs.getString("mb_id"));
					rv.setRating(rs.getInt("rating"));
					rv.setRv_text(rs.getString("rv_text"));
					rv.setRv_uid(rs.getInt("rv_uid"));
					rv.setRv_date(rs.getString("rv_date"));
					rv.setRv_sub(rs.getString("rv_sub"));
					rv.setFile1_thumb(rs.getString("file1_thumb"));

					r.add(rv);
				}
				rs.close();
				pstmt.close();
				d.con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return r;
		}
	
	// 리뷰 가져오기
	public ArrayList<Reviews> getAllReviews(int startRow, int endRow, int it_uid, String field, String search) {
		d.getCon();
		ArrayList<Reviews> r = new ArrayList<Reviews>();

		try {
			String sql = "";
			if (search != null && !search.equals("")) {
				sql = "select * from reviews where " + field + " like '%" + search + "%' order by rv_date desc limit ?,? ";
			} else {
				sql = "select * from reviews where it_uid=" + it_uid + " order by rv_date desc limit ?,? ";
			}

			pstmt = d.con.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				Reviews rv = new Reviews();

				rv.setIt_uid(rs.getInt("it_uid"));
				rv.setMb_id(rs.getString("mb_id"));
				rv.setRating(rs.getInt("rating"));
				rv.setRv_text(rs.getString("rv_text"));
				rv.setRv_uid(rs.getInt("rv_uid"));
				rv.setRv_date(rs.getString("rv_date"));
				rv.setRv_sub(rs.getString("rv_sub"));
				rv.setFile1(rs.getString("file1"));
				rv.setFile2(rs.getString("file2"));
				rv.setFile3(rs.getString("file3"));
				rv.setFile1_thumb(rs.getString("file1_thumb"));
				
				r.add(rv);
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return r;
	}

	// 총 리뷰 수
	public int getAllcountReview(String field, String search, int it_uid) {
		d.getCon();

		int count = 0;
		try {
			String sql;
			if (search != null && !search.equals("")) {
				sql = "select count(*) from reviews where " + field + " like '%" + search + "%' and it_uid = " + it_uid;
			} else {
				sql = "select count(*) from reviews where it_uid=" + it_uid;
			}
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
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

	// 리뷰 점수 평균
	public double reviewsRating(int it_uid) {
		double average = 0.0;
		d.getCon();

		try {
			String sql = "select avg(rating) as average from reviews where it_uid=?";

			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, it_uid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				average = rs.getDouble("average");
			}

			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return average;
	}
	
	// 총 리뷰 수
	public int getAllcountIQ(String field, String search, int it_uid) {
		d.getCon();

		int iqcount = 0;
		try {
			String sql;
			if (search != null && !search.equals("")) {
				sql = "select count(*) from itemqna where " + field + " like '%" + search + "%' and it_uid = " + it_uid;
			} else {
				sql = "select count(*) from itemqna where it_uid=" + it_uid;
			}
			pstmt = d.con.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				iqcount = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return iqcount;
	}

	// 리뷰 한개
	public Reviews oneReview(int rv_uid) {
		d.getCon();
		Reviews re = new Reviews();
		try {
			String sql = "select * from reviews where rv_uid=?";
			pstmt = d.con.prepareStatement(sql);

			pstmt.setInt(1, rv_uid);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				re.setIt_uid(rs.getInt("it_uid"));
				re.setMb_id(rs.getString("mb_id"));
				re.setRating(rs.getInt("rating"));
				re.setRv_date(rs.getString("rv_date"));
				re.setRv_sub(rs.getString("rv_sub"));
				re.setRv_text(rs.getString("rv_text"));
				re.setRv_uid(rv_uid);
				re.setFile1(rs.getString("file1"));
				re.setFile2(rs.getString("file2"));
				re.setFile3(rs.getString("file3"));
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return re;
	}

////////////////////////////////////////계층형////////////////////////////////////////
	// 상품페이지 문의글 계층형 불러오기
		public ArrayList<ItemQna> someItemQna(int startRow, int endRow, int it_uid, String field, String search) {
			d.getCon();
			ArrayList<ItemQna> q = new ArrayList<ItemQna>();

			try {
				String sql = "";
				if (search != null && !search.equals("")) {
					sql = "select * from itemqna where " + field + " like '%" + search + "%' order by fid desc,thread asc limit ?,?";
				} else {
					sql = "select * from itemqna where it_uid=" + it_uid + " order by fid desc,thread asc limit ?,?";
				}

				pstmt = d.con.prepareStatement(sql);

				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);

				rs = pstmt.executeQuery();

				while (rs.next()) {
					ItemQna qna = new ItemQna();

					qna.setComment(rs.getNString("comment"));
					qna.setFid(rs.getInt("fid"));
					qna.setType1(rs.getString("type1"));
					qna.setIt_uid(rs.getInt("it_uid"));
					qna.setMb_id(rs.getString("mb_id"));
					qna.setQna_uid(rs.getInt("qna_uid"));
					qna.setRef(rs.getInt("ref"));
					qna.setSigndate(rs.getString("signdate"));
					qna.setQna_subject(rs.getString("qna_subject"));
					qna.setThread(rs.getString("thread"));

					q.add(qna);
				}
				rs.close();
				pstmt.close();
				d.con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			return q;
		}
	
	
	// 상품페이지 문의글 계층형 불러오기
	public ArrayList<ItemQna> getAllitemqna(int startRow, int endRow, int it_uid, String field, String search) {
		d.getCon();
		ArrayList<ItemQna> q = new ArrayList<ItemQna>();

		try {
			String sql = "";
			if (search != null && !search.equals("")) {
				sql = "select * from itemqna where " + field + " like '%" + search + "%' order by fid desc,thread asc limit ?,?";
			} else {
				sql = "select * from itemqna where it_uid=" + it_uid + " order by fid desc,thread asc limit ?,?";
			}

			pstmt = d.con.prepareStatement(sql);

			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ItemQna qna = new ItemQna();

				qna.setComment(rs.getNString("comment"));
				qna.setFid(rs.getInt("fid"));
				qna.setType1(rs.getString("type1"));
				qna.setIt_uid(rs.getInt("it_uid"));
				qna.setMb_id(rs.getString("mb_id"));
				qna.setQna_uid(rs.getInt("qna_uid"));
				qna.setRef(rs.getInt("ref"));
				qna.setSigndate(rs.getString("signdate"));
				qna.setQna_subject(rs.getString("qna_subject"));
				qna.setThread(rs.getString("thread"));

				q.add(qna);
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return q;
	}

	// 상품페이지 문의글 계층형 카운팅
	public int getAllIQCount(String field, String search, int it_uid) {
		d.getCon();
		int count = 0;

		try {
			String sql;
			if (search != null && !search.equals("")) {
				sql = "select count(*) from itemqna where " + field + " like '%" + search + "%' and it_uid = " + it_uid;
			} else {
				sql = "select count(*) from itemqna where it_uid=" + it_uid;
			}

			pstmt = d.con.prepareStatement(sql);
			pstmt.executeQuery();
			if (rs.next()) {
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
	// fid 가져오기
	public int getFid(int it_uid) {
		d.getCon();
		int new_fid = 1; // 새로운 fid 값 초기화
		try {
			String sql = "select max(fid) as fid_max from itemqna where it_uid=?";
			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, it_uid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int fid_max = rs.getInt("fid_max");
				if (fid_max > 0) {
					new_fid = fid_max + 1; // 새로운 fid 값 설정
				}
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new_fid; // 새로운 fid 값 반환
	}

	// thread 가져오기
	public String getThread(int fid, String thread) {
		d.getCon();
		String new_thread = "";
		try {
			String sql = "select right(thread,1) as thread_right from itemqna where fid = ? AND length(thread) = length(?)+1 AND locate(?,thread) = 1 ORDER BY thread DESC limit 1";

			pstmt = d.con.prepareStatement(sql);

			pstmt.setInt(1, fid);
			pstmt.setString(2, thread);
			pstmt.setString(3, thread);

			rs = pstmt.executeQuery();

			new_thread = thread + "A";

			if (rs.next()) { // 형제 thread 추출
				String r_thread = rs.getString("thread_right");
				new_thread = thread + (char) (r_thread.charAt(0) + 1);
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new_thread;
	}

	// 문의글 인서트
	public void insertItemQna(ItemQna iq) {
		d.getCon();

		try {
			String sql = "insert into itemqna values (null,?,?,?,?,?,null,?,?,?)";

			pstmt = d.con.prepareStatement(sql);

			pstmt.setString(1, iq.getMb_id());
			pstmt.setInt(2, iq.getIt_uid());
			pstmt.setString(3, iq.getQna_subject());
			pstmt.setString(4, iq.getComment());
			pstmt.setString(5, iq.getSigndate());
			pstmt.setString(6, iq.getType1());
			pstmt.setInt(7, iq.getFid());
			pstmt.setString(8, iq.getThread());

			pstmt.executeUpdate();

			pstmt.close();
			d.con.close();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 문의글 하나만 보기
	public ItemQna oneItemQna(int qna_uid, int it_uid) {
		d.getCon();
		ItemQna iq = new ItemQna();

		try {
			String sql = "select * from itemqna where qna_uid=? and it_uid=?";
			pstmt = d.con.prepareStatement(sql);

			pstmt.setInt(1, qna_uid);
			pstmt.setInt(2, it_uid);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				iq.setComment(rs.getString("comment"));
				iq.setFid(rs.getInt("fid"));
				iq.setIt_uid(rs.getInt("it_uid"));
				iq.setMb_id(rs.getString("mb_id"));
				iq.setQna_subject(rs.getString("qna_subject"));
				iq.setQna_uid(rs.getInt("qna_uid"));
				iq.setRef(rs.getInt("ref"));
				iq.setSigndate(rs.getString("signdate"));
				iq.setThread(rs.getString("thread"));
				iq.setType1(rs.getString("type1"));
			}
			rs.close();
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return iq;
	}
	
	//문의글답변
	public void qnaAnswer() {
		d.getCon();

		try {
			String sql = "select right(thread,1) as thread_right from itemqna where fid = ? AND length(thread) = length(?)+1 AND locate(?,thread) = 1 ORDER BY thread DESC limit 1";

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//계층형 수정
	public void qnaUpdate(ItemQna iq) {
		d.getCon();
		try {
			String sql = "update itemqna set qna_subject=?,comment=?,type1=? where qna_uid=?";

			pstmt = d.con.prepareStatement(sql);

			pstmt.setString(1, iq.getQna_subject());
			pstmt.setString(2, iq.getComment());
			pstmt.setString(3, iq.getType1());
			pstmt.setInt(4, iq.getQna_uid());

			pstmt.executeUpdate();

			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//답글 존재여부 확인
	public int getFidLength(String it_uid, int fid) {
		d.getCon();
		int fidLength = 0;
		try {
			String sql = "select count(*) from itemqna where it_uid=? and fid = ?;";
			pstmt = d.con.prepareStatement(sql);
			pstmt.setString(1, it_uid);
			pstmt.setInt(2, fid);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				fidLength = rs.getInt(1);
			}
			pstmt.close();
			d.con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fidLength;
	}
	
	//답글 없으면 삭제!
	public void qnaDelete(int qna_uid) {
		d.getCon();
		try {
			String sql = "delete from itemqna where qna_uid = ?";
			pstmt = d.con.prepareStatement(sql);
			pstmt.setInt(1, qna_uid);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}	
	}
	
	// 중분류에 따른 상품 목록 조회
	public ArrayList<Item> getAllItem2(int startRow, int endRow, String field, String search, String cate1, String cate2) {
	    d.getCon();
	    ArrayList<Item> v = new ArrayList<Item>();
	    try {
	        String sql = "";
	        if (search != null && !search.equals("")) {
	            sql = "SELECT *, (SELECT AVG(rating) FROM reviews WHERE reviews.it_uid=item.it_uid GROUP BY it_uid) AS avg_rating FROM item WHERE category1=? AND category2=?" + field + " LIKE '%" + search + "%' ORDER BY it_uid DESC LIMIT ?,?";
	        } else {
	            sql = "SELECT *, (SELECT AVG(rating) FROM reviews WHERE reviews.it_uid=item.it_uid GROUP BY it_uid) AS avg_rating FROM item WHERE category1=? AND category2=? ORDER BY it_uid DESC LIMIT ?,?";
	        }

	        pstmt = d.con.prepareStatement(sql);
	        pstmt.setString(1, cate1);
	        pstmt.setString(2, cate2);
	        pstmt.setInt(3, startRow);
	        pstmt.setInt(4, endRow);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Item it = new Item();

	            it.setCategory1(rs.getString("category1"));
	            it.setCategory2(rs.getString("category2"));
	            it.setFile1(rs.getString("file1"));
	            it.setFile1_thumb(rs.getString("File1_thumb"));
	            it.setIt_name(rs.getString("it_name"));
	            it.setIt_option(rs.getString("it_option"));
	            it.setIt_point(rs.getInt("it_point"));
	            it.setIt_price(rs.getInt("it_price"));
	            it.setIt_sale(rs.getInt("it_sale"));
	            it.setIt_qty(rs.getInt("it_qty"));
	            it.setIt_type1(rs.getString("it_type1"));
	            it.setIt_type2(rs.getString("it_type2"));
	            it.setIt_type3(rs.getString("it_type3"));
	            it.setIt_type4(rs.getString("it_type4"));
	            it.setIt_type5(rs.getString("it_type5"));
	            it.setIt_uid(rs.getInt("it_uid"));
	            it.setIt_use(rs.getString("it_use"));
	            it.setMb_id(rs.getString("mb_id"));
	            it.setAvg_rating(rs.getDouble("avg_rating"));

	            v.add(it);
	        }
	        rs.close();
	        pstmt.close();
	        d.con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return v;
	}

	// 중분류에 따른 상품 갯수 조회
	public int getCateCount2(String field, String search, String cate1, String cate2) {
	    d.getCon();

	    int count = 0;
	    try {
	        String sql;
	        if (search != null && !search.equals("")) {
	            sql = "SELECT COUNT(*) FROM item WHERE category1 = ? AND category2 = ? AND " + field + " LIKE '%" + search + "%'";
	        } else {
	            sql = "SELECT COUNT(*) FROM item WHERE category1 = ? AND category2 = ?";
	        }
	        pstmt = d.con.prepareStatement(sql);
	        pstmt.setString(1, cate1);
	        pstmt.setString(2, cate2);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
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

	// 검색어에 따른 상품 갯수 조회
	public int getCateCount1(String search) {
	    d.getCon();

	    int count = 0;
	    try {
	        String sql = "SELECT COUNT(*) FROM item WHERE it_name LIKE '%" + search + "%' AND it_qty > 0";

	        pstmt = d.con.prepareStatement(sql);
	        rs = pstmt.executeQuery();

	        if (rs.next()) {
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

	// 검색어에 따른 상품 목록 조회
	public ArrayList<Item> getAllItem1(int startRow, int endRow, String search) {
	    d.getCon();
	    ArrayList<Item> v = new ArrayList<Item>();
	    try {
	        String sql = "SELECT *, (SELECT AVG(rating) FROM reviews WHERE reviews.it_uid=item.it_uid GROUP BY it_uid) AS avg_rating FROM item WHERE it_name LIKE '%" + search + "%' ORDER BY it_uid DESC LIMIT ?,?";;

	        pstmt = d.con.prepareStatement(sql);

	        pstmt.setInt(1, startRow);
	        pstmt.setInt(2, endRow);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Item it = new Item();

	            it.setCategory1(rs.getString("category1"));
	            it.setCategory2(rs.getString("category2"));
	            it.setFile1(rs.getString("file1"));
	            it.setFile1_thumb(rs.getString("File1_thumb"));
	            it.setIt_name(rs.getString("it_name"));
	            it.setIt_option(rs.getString("it_option"));
	            it.setIt_point(rs.getInt("it_point"));
	            it.setIt_price(rs.getInt("it_price"));
	            it.setIt_sale(rs.getInt("it_sale"));
	            it.setIt_qty(rs.getInt("it_qty"));
	            it.setIt_type1(rs.getString("it_type1"));
	            it.setIt_type2(rs.getString("it_type2"));
	            it.setIt_type3(rs.getString("it_type3"));
	            it.setIt_type4(rs.getString("it_type4"));
	            it.setIt_type5(rs.getString("it_type5"));
	            it.setIt_uid(rs.getInt("it_uid"));
	            it.setIt_use(rs.getString("it_use"));
	            it.setMb_id(rs.getString("mb_id"));
	            it.setAvg_rating(rs.getDouble("avg_rating"));

	            v.add(it);
	        }
	        rs.close();
	        pstmt.close();
	        d.con.close();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return v;
	}

}
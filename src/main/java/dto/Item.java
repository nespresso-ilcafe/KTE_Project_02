package dto;

import lombok.Data;

@Data
public class Item {
	private int it_uid;
	private String category1;
	private String category2;
	private String mb_id;
	private String it_name;
	private int it_sale; //세일가격
	private int it_price; //가격
	private int it_point;
	private int it_qty; //재고수량
	private String it_option; //옵션
	private String it_use; //판매여부
	private String it_date; //작성일
	private String it_type1; //히트
	private String it_type2; //추천
	private String it_type3; //신상
	private String it_type4; //인기
	private String it_type5; //할인
	private String file1;
	private String file2;
	private String file3;
	private String file4;
	private String file5;
	private String file1_thumb; //썸네일
	private String cate2_name;	//제품명
	private double avg_rating;	//평점
}

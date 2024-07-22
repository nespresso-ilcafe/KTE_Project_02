package dto;

import lombok.Data;

@Data
public class Cart {
	private int ct_uid;
	private String mb_id;
	private int it_uid;
	private String it_opt1;
	private int it_price;
	private int it_sale; //세일가격
	private int it_point;
	private int it_qty;
	private String ct_status;
	private String ct_date;
	private String file1_thumb; // item 테이블 file1 
	private Item item; //조인용
}
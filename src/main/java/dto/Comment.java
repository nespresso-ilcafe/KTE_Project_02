package dto;

import lombok.Data;

@Data
public class Comment {
	private int uid;
	private String tb_table;
	private int tb_uid;
	private String tb_id;
	private String tb_comment;
	private String tb_date;
}

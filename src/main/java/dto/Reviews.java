package dto;

import lombok.Data;

@Data
public class Reviews {
	int rv_uid;
	String mb_id;
	int it_uid;
	int rating;
	String rv_text;
	String rv_date;
	String rv_sub;
	String file1;
	String file2;
	String file3;
	String file1_thumb;
}

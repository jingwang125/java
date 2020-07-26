package customer;

import java.util.List;

public interface CustomerService {
	//CRUD ( Create/Read/Update/Delete )
	//신규저장
	void customer_insert(CustomerVO vo);
	//목록조회
	List<CustomerVO> customer_list();
	//상세조회
	CustomerVO customer_detail(int id);
	//변경저장
	void customer_update(CustomerVO vo);
	//삭제
	void customer_delete(int id);
}

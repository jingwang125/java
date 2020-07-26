package notice;

import java.util.List;

import org.springframework.stereotype.Component;

import common.PageVO;

@Component
public class NoticePageVO extends PageVO {	//superclass로 PageVO 상속(PageVO의 setter, getter 모든 것 받을 수 있음)
	private List<NoticeVO> list;

	public List<NoticeVO> getList() {
		return list;
	}

	public void setList(List<NoticeVO> list) {
		this.list = list;
	}
	
}

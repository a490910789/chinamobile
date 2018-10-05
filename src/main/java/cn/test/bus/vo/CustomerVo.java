package cn.test.bus.vo;

import cn.test.bus.domain.Customer;
import cn.test.sys.domain.Operator;

public class CustomerVo extends Customer {

	private static final long serialVersionUID = 1L;
	private Integer page;
	private Integer limit;
	private Integer[] ids;

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public Integer[] getIds() {
		return ids;
	}

	public void setIds(Integer[] ids) {
		this.ids = ids;
	}
}

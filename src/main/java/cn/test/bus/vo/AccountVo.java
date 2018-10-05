package cn.test.bus.vo;

import cn.test.bus.domain.Account;

public class AccountVo extends Account {

	private static final long serialVersionUID = 1L;
	private Integer page;
	private Integer limit;
	private Integer[] ids;
	private Double recharge;

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

	public Double getRecharge() {
		return recharge;
	}

	public void setRecharge(Double recharge) {
		this.recharge = recharge;
	}

}

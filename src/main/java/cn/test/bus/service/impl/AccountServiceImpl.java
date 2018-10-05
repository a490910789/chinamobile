package cn.test.bus.service.impl;

import cn.test.bus.domain.Account;
import cn.test.bus.domain.Account;
import cn.test.bus.mapper.AccountMapper;
import cn.test.bus.mapper.AccountMapper;
import cn.test.bus.service.AccountService;
import cn.test.bus.vo.AccountVo;
import cn.test.bus.vo.AccountVo;
import cn.test.sys.utils.DataGridView;

import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chen
 * @since 2018-10-05
 */
@Service
public class AccountServiceImpl extends ServiceImpl<AccountMapper, Account> implements AccountService {
	@Autowired
	private AccountMapper accountMapper;
	//分页查询
	@Override
	public DataGridView queryForPage(AccountVo accountVo) {
		Pagination pagination=new Pagination(accountVo.getPage(), accountVo.getLimit());
		List<Account> data=this.accountMapper.queryForPage(accountVo);
		return new DataGridView(pagination.getTotal(), data);
	}
}

package cn.test.bus.service;

import cn.test.bus.domain.Account;
import cn.test.bus.vo.AccountVo;
import cn.test.sys.utils.DataGridView;

import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chen
 * @since 2018-10-05
 */
public interface AccountService extends IService<Account> {

	DataGridView queryForPage(AccountVo accountVo);

}

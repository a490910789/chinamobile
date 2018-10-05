package cn.test.bus.mapper;

import cn.test.bus.domain.Account;
import cn.test.bus.vo.AccountVo;

import java.util.List;

import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author chen
 * @since 2018-10-05
 */
public interface AccountMapper extends BaseMapper<Account> {

	List<Account> queryForPage(AccountVo accountVo);

}

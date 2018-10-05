package cn.test.bus.mapper;

import cn.test.bus.domain.Customer;
import cn.test.bus.vo.CustomerVo;

import java.util.List;

import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author chen
 * @since 2018-10-03
 */
public interface CustomerMapper extends BaseMapper<Customer> {
	List<Customer> queryForPage(CustomerVo customerVo);
}

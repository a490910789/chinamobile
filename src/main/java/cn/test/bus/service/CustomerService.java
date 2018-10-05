package cn.test.bus.service;

import cn.test.bus.domain.Customer;
import cn.test.bus.vo.CustomerVo;
import cn.test.sys.utils.DataGridView;

import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chen
 * @since 2018-10-03
 */
public interface CustomerService extends IService<Customer> {

	DataGridView queryForPage(CustomerVo customer);
 
}

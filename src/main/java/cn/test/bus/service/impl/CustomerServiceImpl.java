package cn.test.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import cn.test.bus.domain.Customer;
import cn.test.bus.mapper.CustomerMapper;
import cn.test.bus.service.CustomerService;
import cn.test.bus.vo.CustomerVo;
import cn.test.sys.utils.DataGridView;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chen
 * @since 2018-10-03
 */
@Service
public class CustomerServiceImpl extends ServiceImpl<CustomerMapper, Customer> implements CustomerService {
	@Autowired
	private CustomerMapper customerMapper;
	//分页查询
	@Override
	public DataGridView queryForPage(CustomerVo customerVo) {
		Pagination pagination=new Pagination(customerVo.getPage(), customerVo.getLimit());
		List<Customer> data=this.customerMapper.queryForPage(customerVo);
		return new DataGridView(pagination.getTotal(), data);
	}
}

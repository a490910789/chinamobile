package cn.test.bus.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import cn.test.bus.domain.Customer;
import cn.test.bus.service.CustomerService;
import cn.test.bus.vo.CustomerVo;
import cn.test.sys.utils.DataGridView;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author chen
 * @since 2018-10-03
 */
@Controller
@RequestMapping("/customer")
public class CustomerController {
	@Autowired
	private CustomerService customerService;

	// 跳转客户列表
	@RequestMapping("toCustomerManager")
	public String toCustomerManager() {
		return "business/customer/customerManager";
	}

	// 跳转添加页面
	@RequestMapping("toAddCustomer")
	public String toAddCustomer(CustomerVo customerVo) {
			return "business/customer/addCustomerStepOne";
	}
	// 跳转添加页面
	@RequestMapping("addCustomerCheckStepOne")
	public String addCustomerCheckStepOne(CustomerVo customerVo) {
		// 添加前先判断客户是否存在
		Wrapper<Customer> wrapper = new EntityWrapper<>();
		wrapper.andNew("cname =({0})", customerVo.getCname()).andNew("identity =({0})", customerVo.getIdentity());
		Customer customer = this.customerService.selectOne(wrapper);
		if (null == customer) {
			return "business/customer/addCustomerStepTwo";
		}else {
			return "business/customer/customerInfo";
		}
	}

	// 跳转修改页面
	@RequestMapping("toUpdateCustomer")
	public String toUpdateCustomer(CustomerVo customerVo, Model model) {
		Customer customer = this.customerService.selectById(customerVo.getCid());
		model.addAttribute("customer", customer);
		return "business/customer/updateCustomer";
	}

	@RequestMapping("queryAllCustomer")
	@ResponseBody
	public DataGridView queryAllCustomer(CustomerVo customerVo) {
		return this.customerService.queryForPage(customerVo);
	}
	@RequestMapping("queryCustomerByIdentity")
	@ResponseBody
	public DataGridView queryCustomerByIdentity(CustomerVo customerVo) {
		Map<String, Object> columnMap=new HashMap<>();
		columnMap.put("identity", customerVo.getIdentity());
		List<Customer> data = this.customerService.selectByMap(columnMap);
		return new DataGridView(Long.valueOf(data.size()), data);
	}

	@RequestMapping("deleteCustomer")
	@ResponseBody
	public Map<String, Object> deleteCustomer(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.customerService.deleteById(customerVo.getCid());
			if (flag) {
				msg = "删除成功";
			} else {
				msg = "删除失败";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败";
		}
		map.put("msg", msg);
		return map;
	}

	// 批量删除
	@RequestMapping("deleteCustomers")
	@ResponseBody
	public Map<String, Object> deleteCustomers(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			List<Integer> idList = new ArrayList<>();
			Integer[] ids = customerVo.getIds();
			for (Integer cid : ids) {
				idList.add(cid);
			}
			boolean flag = this.customerService.deleteBatchIds(idList);
			if (flag) {
				msg = "删除成功";
			} else {
				msg = "删除失败";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "删除失败";
		}
		map.put("msg", msg);
		return map;
	}

	@RequestMapping("addCustomer")
	@ResponseBody
	public Map<String, Object> addCustomer(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.customerService.insert(customerVo);
			if (flag) {
				msg = "添加成功";
			} else {
				msg = "添加失败";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "添加失败";
		}
		map.put("msg", msg);
		return map;
	}

	@RequestMapping("updateCustomer")
	@ResponseBody
	public Map<String, Object> updateCustomer(CustomerVo customerVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.customerService.updateAllColumnById(customerVo);
			if (flag) {
				msg = "修改成功";
			} else {
				msg = "修改失败";
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = "修改失败";
		}
		map.put("msg", msg);
		return map;
	}
}

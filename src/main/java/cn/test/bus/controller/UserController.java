package cn.test.bus.controller;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import cn.test.bus.domain.Account;
import cn.test.bus.domain.Customer;
import cn.test.bus.domain.User;
import cn.test.bus.service.AccountService;
import cn.test.bus.service.CustomerService;
import cn.test.bus.service.UserService;
import cn.test.bus.vo.AccountVo;
import cn.test.bus.vo.CustomerVo;
import cn.test.bus.vo.UserVo;
import cn.test.sys.utils.DataGridView;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author chen
 * @since 2018-10-04
 */
@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private CustomerService customerService;
	@Autowired
	private AccountService accountService;

	// 跳转客户列表
	@RequestMapping("toUserManager")
	public String toUserManager() {
		return "business/user/userManager";
	}

	// 跳转添加页面
	@RequestMapping("toAddUser")
	public String toAddUser() {
		return "business/user/addUserStepOne";
	}
	// 跳转添加页面step1
	@RequestMapping("addUserCheckStepOne")
	public String addCustomerCheckStepOne(CustomerVo customerVo,Model model) {
		// 添加前先判断客户是否存在
		Wrapper<Customer> wrapper = new EntityWrapper<>();
		wrapper.andNew("identity =({0})", customerVo.getIdentity());
		Customer customer = this.customerService.selectOne(wrapper);
		if (null == customer) {
			return "business/customer/addCustomerStepTwo";
		}else {
			User user = this.userService.queryUserByCid(customer.getCid());
			model.addAttribute("user",user);
			model.addAttribute("customer", customer);
			return "business/user/addUserStepTwo";
		}
	}
	// 跳转添加页面step2
	@RequestMapping("addUserStepTwo")
	public String addUserStepTwo(CustomerVo customerVo,UserVo userVo,HttpSession session,Model model) {
		String phone = userVo.getPhone();
		if(userVo.getAccountid()!="") {
			Wrapper<Account> wrapper=new EntityWrapper<>();
			wrapper.andNew("aid =({0})", userVo.getAccountid());
			Account account = this.accountService.selectOne(wrapper);
			session.setAttribute(phone+"", userVo);
			model.addAttribute("account", account);
			return "business/user/addUserStepThree";
		}else {
			this.userService.insert(userVo);
			model.addAttribute("customerVo", customerVo);
			return "business/account/addAccount";
		}
	}
	// 跳转添加页面step3
	@RequestMapping("addUserStepThree")
	@ResponseBody
	public Map<String, Object> addUserStepThree(AccountVo accountVo,UserVo userVo,HttpSession session) {
	    Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			UserVo userVo2 = (UserVo) session.getAttribute(userVo.getPhone()+"");
			//充值后的余额
			accountVo.setBalance(accountVo.getBalance()+accountVo.getRecharge());
			this.accountService.updateById(accountVo);
			boolean flag = this.userService.insert(userVo2);
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

	// 跳转修改页面
	@RequestMapping("toUpdateUser")
	public String toUpdateUser(UserVo userVo, Model model) {
		User user = this.userService.queryUserByCid(userVo.getUid());
		model.addAttribute("user", user);
		return "business/user/updateUser";
	}

	@RequestMapping("queryAllUser")
	@ResponseBody
	public DataGridView queryAllUser(UserVo userVo) {
		return this.userService.queryForPage(userVo);
	}

	@RequestMapping("deleteUser")
	@ResponseBody
	public Map<String, Object> deleteUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.userService.deleteById(userVo.getUid());
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
	@RequestMapping("deleteUsers")
	@ResponseBody
	public Map<String, Object> deleteUsers(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			List<Integer> idList = new ArrayList<>();
			Integer[] ids = userVo.getIds();
			for (Integer cid : ids) {
				idList.add(cid);
			}
			boolean flag = this.userService.deleteBatchIds(idList);
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


	@RequestMapping("updateUser")
	@ResponseBody
	public Map<String, Object> updateUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.userService.updateAllColumnById(userVo);
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


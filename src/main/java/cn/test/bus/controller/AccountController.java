package cn.test.bus.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import cn.test.bus.domain.Account;
import cn.test.bus.domain.User;
import cn.test.bus.service.AccountService;
import cn.test.bus.service.UserService;
import cn.test.bus.vo.AccountVo;
import cn.test.bus.vo.UserVo;
import cn.test.sys.utils.DataGridView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author chen
 * @since 2018-10-05
 */
@Controller
@RequestMapping("/account")
public class AccountController {
	@Autowired
	private AccountService accountService;
	@Autowired
	private UserService userService;

	// 跳转资源列表
	@RequestMapping("toAccountManager")
	public String toAccountManager() {
		return "business/account/accountManager";
	}

	// 跳转添加页面
	@RequestMapping("toAddAccount")
	public String toAddAccount() {
		return "business/account/addAccount";
	}

	// 跳转修改页面
	@RequestMapping("toUpdateAccount")
	public String toUpdateAccount(AccountVo accountVo, Model model) {
		 Account account = this.accountService.selectById(accountVo.getAid());
		 model.addAttribute("account", account);
		 return "business/account/updateAccount";
	}

	@RequestMapping("queryAllAccount")
	@ResponseBody
	public DataGridView queryAllAccount(AccountVo accountVo) {
		return this.accountService.queryForPage(accountVo);
	}

	@RequestMapping("deleteAccount")
	@ResponseBody
	public Map<String, Object> deleteAccount(AccountVo accountVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.accountService.deleteById(accountVo.getAid());
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

	@RequestMapping("addAccount")
	@ResponseBody
	public Map<String, Object> addAccount(AccountVo accountVo,UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.accountService.insert(accountVo);
			Wrapper<User> wrapper=new EntityWrapper<>();
			wrapper.andNew("phone =({0})", userVo.getPhone());
			User user = this.userService.selectOne(wrapper);
			user.setAccountid(accountVo.getAid());
			this.userService.updateById(user);
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

	@RequestMapping("updateAccount")
	@ResponseBody
	public Map<String, Object> updateAccount(AccountVo accountVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.accountService.updateAllColumnById(accountVo);
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


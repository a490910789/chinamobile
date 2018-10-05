package cn.test.sys.controller;

import java.util.ArrayList;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;

import cn.test.sys.constast.SYS_Constast;
import cn.test.sys.domain.Menu;
import cn.test.sys.domain.Operator;
import cn.test.sys.service.MenuService;
import cn.test.sys.service.OperatorService;
import cn.test.sys.utils.SessionUtils;
import cn.test.sys.utils.TreeNode;
import cn.test.sys.utils.TreeNodeBuilder;
import cn.test.sys.vo.MenuVo;

@Controller
@RequestMapping("login")
public class LoginController {
	@Autowired
	private OperatorService operatorService;
	@Autowired
	private MenuService menuService;

	/**
	 * 跳转到用户登陆的页面
	 */
	@RequestMapping("toLogin")
	public String toLogin() {
		return "system/main/login";
	}
	/**
	 * 跳转欢迎页面
	 */
	@RequestMapping("toInfo")
	public String toInfo() {
		return "system/main/info";
	}


	@RequestMapping("login")
	public String login(Operator operator, HttpSession session) {
		Wrapper<Operator> wrapper = new EntityWrapper<>();
		wrapper.andNew("loginname =({0})", operator.getLoginname()).andNew("pwd =({0})", operator.getPwd());
		Operator operator2 = this.operatorService.selectOne(wrapper);
		if (null != operator2) {
			session.setAttribute("operator", operator2);
			return "system/main/index";
		} else {
			return "system/main/login";
		}
	}

	@RequestMapping("loadLeftMenu")
	@ResponseBody
	public List<TreeNode> loadLeftMenu(MenuVo menuVo) {
		Operator operator = SessionUtils.getUserInSession("operator");
		List<TreeNode> treeNodes = new ArrayList<>();
		List<Menu> menus = null;
		if (operator.getType() == SYS_Constast.USER_TYPE_SUPER) {
			Wrapper<Menu> wrapper = new EntityWrapper<>();
			wrapper.andNew("available =({0})", SYS_Constast.TYPE_AVAILABLE_YES);
			menus = this.menuService.selectList(wrapper);
		} else {
			Wrapper<Menu> wrapper = new EntityWrapper<>();
			wrapper.andNew("available =({0})", SYS_Constast.TYPE_AVAILABLE_YES);
			menus = this.menuService.selectList(wrapper);
		}
		for (Menu m : menus) {
			Boolean open = m.getOpen() == SYS_Constast.TYPE_PUBLIC_ONE ? true : false;
			treeNodes.add(
					new TreeNode(m.getId(), m.getPid(), m.getName(), m.getHref(), m.getIcon(), open, m.getTarget()));
		}
		List<TreeNode> nodes = TreeNodeBuilder.builder(treeNodes, 1);
		return nodes;
	}
}

package cn.test.bus.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.test.bus.domain.Numberrs;
import cn.test.bus.service.NumberrsService;
import cn.test.bus.vo.NumberrsVo;
import cn.test.sys.constast.SYS_Constast;
import cn.test.sys.utils.DataGridView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author chen
 * @since 2018-10-04
 */
@Controller
@RequestMapping("/numberrs")
public class NumberrsController {
	@Autowired
	private NumberrsService numberrsService;

	// 跳转资源列表
	@RequestMapping("toNumberrsManager")
	public String toNumberrsManager() {
		return "business/numberrs/numberrsManager";
	}

	// 跳转添加页面
	@RequestMapping("toAddNumberrs")
	public String toAddNumberrs() {
		return "business/numberrs/addNumberrs";
	}

	// 跳转修改页面
	@RequestMapping("toUpdateNumberrs")
	public String toUpdateNumberrs(NumberrsVo numberrsVo, Model model) {
		 Numberrs numberrs = this.numberrsService.selectById(numberrsVo.getPhonenumber());
		 model.addAttribute("numberrs", numberrs);
		 return "business/numberrs/updateNumberrs";
	}

	@RequestMapping("queryAllNumberrs")
	@ResponseBody
	public DataGridView queryAllNumberrs(NumberrsVo numberrsVo) {
		return this.numberrsService.queryForPage(numberrsVo);
	}

	@RequestMapping("deleteNumberrs")
	@ResponseBody
	public Map<String, Object> deleteNumberrs(NumberrsVo numberrsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.numberrsService.deleteById(numberrsVo.getPhonenumber());
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
	@RequestMapping("deleteNumberrss")
	@ResponseBody
	public Map<String, Object> deleteNumberrss(NumberrsVo numberrsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			List<Integer> idList = new ArrayList<>();
			Integer[] ids = numberrsVo.getIds();
			for (Integer cid : ids) {
				idList.add(cid);
			}
			boolean flag = this.numberrsService.deleteBatchIds(idList);
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

	@RequestMapping("addNumberrs")
	@ResponseBody
	public Map<String, Object> addNumberrs(NumberrsVo numberrsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.numberrsService.insert(numberrsVo);
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

	@RequestMapping("updateNumberrs")
	@ResponseBody
	public Map<String, Object> updateNumberrs(NumberrsVo numberrsVo) {
		Map<String, Object> map = new HashMap<>();
		String msg = null;
		try {
			boolean flag = this.numberrsService.updateAllColumnById(numberrsVo);
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


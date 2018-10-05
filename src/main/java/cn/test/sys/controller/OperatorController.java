package cn.test.sys.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.test.sys.domain.Operator;
import cn.test.sys.service.OperatorService;
import cn.test.sys.utils.DataGridView;
import cn.test.sys.vo.OperatorVo;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author chen
 * @since 2018-10-01
 */
@Controller
@RequestMapping("/operator")
public class OperatorController {
	@Autowired
	private OperatorService operatorService;

	@RequestMapping("toOperatorManager")
	public String toOperatorManager() {
		return "system/operator/operatorManager";
	}

	@RequestMapping("queryAllOperator")
	@ResponseBody
	public DataGridView queryAllOperator(OperatorVo operatorVo) {
		return this.operatorService.queryForPage(operatorVo);
	}
}

package cn.test.sys.service;

import cn.test.sys.domain.Operator;
import cn.test.sys.utils.DataGridView;
import cn.test.sys.vo.OperatorVo;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chen
 * @since 2018-10-01
 */
public interface OperatorService extends IService<Operator> {

	DataGridView queryForPage(OperatorVo operatorVo);

}

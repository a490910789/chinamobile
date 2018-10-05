package cn.test.sys.mapper;

import java.util.List;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import cn.test.sys.domain.Operator;
import cn.test.sys.vo.OperatorVo;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author chen
 * @since 2018-10-01
 */
public interface OperatorMapper extends BaseMapper<Operator> {

	public List<Operator> queryForPage(Pagination pagination, OperatorVo operatorVo);

}

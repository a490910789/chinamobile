package cn.test.sys.service.impl;

import cn.test.sys.domain.Operator;
import cn.test.sys.mapper.OperatorMapper;
import cn.test.sys.service.OperatorService;
import cn.test.sys.utils.DataGridView;
import cn.test.sys.vo.OperatorVo;

import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chen
 * @since 2018-10-01
 */
@Service
public class OperatorServiceImpl extends ServiceImpl<OperatorMapper, Operator> implements OperatorService {
   
	@Autowired
	private OperatorMapper operatorMapper;
	//分页查询
	@Override
	public DataGridView queryForPage(OperatorVo operatorVo) {
		Pagination pagination=new Pagination(operatorVo.getPage(),operatorVo.getLimit());
		List<Operator> data=this.operatorMapper.queryForPage(pagination,operatorVo);
		return new DataGridView(pagination.getTotal(), data);
	}
}

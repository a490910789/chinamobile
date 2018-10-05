package cn.test.bus.service.impl;

import cn.test.bus.domain.Numberrs;
import cn.test.bus.domain.Numberrs;
import cn.test.bus.mapper.NumberrsMapper;
import cn.test.bus.mapper.NumberrsMapper;
import cn.test.bus.service.NumberrsService;
import cn.test.bus.vo.NumberrsVo;
import cn.test.bus.vo.NumberrsVo;
import cn.test.sys.utils.DataGridView;

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
 * @since 2018-10-04
 */
@Service
public class NumberrsServiceImpl extends ServiceImpl<NumberrsMapper, Numberrs> implements NumberrsService {

	@Autowired
	private NumberrsMapper numberrsMapper;
	//分页查询
	@Override
	public DataGridView queryForPage(NumberrsVo numberrsVo) {
		Pagination pagination=new Pagination(numberrsVo.getPage(), numberrsVo.getLimit());
		List<Numberrs> data=this.numberrsMapper.queryForPage(numberrsVo);
		return new DataGridView(pagination.getTotal(), data);
	}

}

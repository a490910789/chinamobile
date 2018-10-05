package cn.test.bus.service;

import cn.test.bus.domain.Numberrs;
import cn.test.bus.vo.NumberrsVo;
import cn.test.sys.utils.DataGridView;

import com.baomidou.mybatisplus.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author chen
 * @since 2018-10-04
 */
public interface NumberrsService extends IService<Numberrs> {

	DataGridView queryForPage(NumberrsVo numberrsVo);

}

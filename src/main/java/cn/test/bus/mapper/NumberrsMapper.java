package cn.test.bus.mapper;

import cn.test.bus.domain.Numberrs;
import cn.test.bus.vo.NumberrsVo;

import java.util.List;

import com.baomidou.mybatisplus.mapper.BaseMapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author chen
 * @since 2018-10-04
 */
public interface NumberrsMapper extends BaseMapper<Numberrs> {

	List<Numberrs> queryForPage(NumberrsVo numberrsVo);

}

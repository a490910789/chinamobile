package cn.test.bus.mapper;

import cn.test.bus.domain.User;
import cn.test.bus.vo.UserVo;

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
public interface UserMapper extends BaseMapper<User> {

	List<User> queryForPage(UserVo userVo);

	User queryUserByUid(Integer uid);

	User queryUserByCid(Integer cid);

}

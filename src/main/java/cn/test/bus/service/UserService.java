package cn.test.bus.service;

import cn.test.bus.domain.User;
import cn.test.bus.vo.UserVo;
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
public interface UserService extends IService<User> {

	DataGridView queryForPage(UserVo userVo);

	User queryUserByUid(Integer uid);

	User queryUserByCid(Integer cid);
}

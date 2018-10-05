package cn.test.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.plugins.pagination.Pagination;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;

import cn.test.bus.domain.User;
import cn.test.bus.mapper.UserMapper;
import cn.test.bus.service.UserService;
import cn.test.bus.vo.UserVo;
import cn.test.sys.utils.DataGridView;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author chen
 * @since 2018-10-04
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
	@Autowired
	private UserMapper userMapper;
	//分页查询
	@Override
	public DataGridView queryForPage(UserVo userVo) {
		Pagination pagination=new Pagination(userVo.getPage(), userVo.getLimit());
		List<User> data=this.userMapper.queryForPage(userVo);
		return new DataGridView(pagination.getTotal(), data);
	}
	@Override
	public User queryUserByUid(Integer uid) {
		return this.userMapper.queryUserByUid(uid);
	}
	@Override
	public User queryUserByCid(Integer cid) {
		return this.userMapper.queryUserByCid(cid);
	}
}

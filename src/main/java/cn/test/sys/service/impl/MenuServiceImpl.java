package cn.test.sys.service.impl;

import cn.test.sys.domain.Menu;
import cn.test.sys.mapper.MenuMapper;
import cn.test.sys.service.MenuService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
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
public class MenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements MenuService {

}

package dendy.rpms.utils;

import dendy.rpms.domain.UserEntity;
import dendy.rpms.entity.User;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

/**
 * 用户工具
 *
 * @author Dendy
 * @since 2013年10月22日
 */
@Component
public class UserUtil {
	private UserUtil() {
	}

	/**
	 * 获取当前登录用户信息
	 *
	 * @return
	 */
	public static UserEntity getUser() {
		UserEntity user = (UserEntity) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//		UserEntity user = new UserEntity("admin", "", new ArrayList<GrantedAuthority>());
//		user.setId(1L);
		return user;
	}

	/**
	 * 获取当前登录用户，返回User对象.
	 *
	 * @return
	 */
	public static User getUserModel() {
		Long id = getUser().getId();
		User user = new User();
		user.setId(id);
		return user;
	}
}

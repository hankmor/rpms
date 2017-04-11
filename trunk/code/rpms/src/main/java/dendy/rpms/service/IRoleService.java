package dendy.rpms.service;

import dendy.rpms.domain.RoleEntity;

import java.util.List;

/**
 * 系统角色服务接口
 *
 * @author Dendy
 * @since 2013年10月17日
 */
public interface IRoleService {
    /**
     * 根据roleCode获取角色
     *
     * @param roleCode 角色代码
     * @param getUsers 级联获取角色的所有用户
     * @return
     */
    RoleEntity getByRoleCode(final String roleCode, boolean getUsers);

    /**
     * 获取系统所有角色
     *
     * @return
     */
    List<RoleEntity> getRoles();
}

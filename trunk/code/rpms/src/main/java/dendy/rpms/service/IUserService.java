package dendy.rpms.service;

import dendy.rpms.domain.UserEntity;
import dendy.rpms.page.Pager;
import dendy.rpms.query.UserQuery;

/**
 * 用户管理服务接口
 *
 * @author Dendy
 * @since 2013-10-11下午2:03:35
 */
public interface IUserService {
    /**
     * 根据用户名获取用户
     *
     * @param userName
     * @return
     */
    UserEntity getByName(String userName);

    /**
     * 根据id获取用户
     *
     * @param id
     * @return
     */
    UserEntity get(Long id);

    /**
     * 修改密码
     *
     * @param id     用户id
     * @param newPwd 新密码
     */
    void editCurrentUserPwd(Long id, String newPwd);

    /**
     * 修改用户信息
     *
     * @param userEntity
     */
    void update(UserEntity userEntity);

    /**
     * 添加用户信息
     *
     * @param userEntity
     */
    void add(UserEntity userEntity);

    /**
     * 删除用户信息
     *
     * @param ids
     */
    void delete(String ids);

    /**
     * 账号启用
     *
     * @param ids
     */
    void setUsing(String ids);

    /**
     * 账号禁用
     *
     * @param ids
     */
    void setForbidden(String ids);

    /**
     * 重置密码
     *
     * @param ids
     */
    void resetPwd(String ids);

    /**
     * 分页查询
     *
     * @param userQuery
     * @return
     */
    Pager<UserEntity> page(UserQuery userQuery);
}

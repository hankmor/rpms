package dendy.rpms.service.impl;

import dendy.rpms.constant.SystemConst;
import dendy.rpms.dao.UserDao;
import dendy.rpms.domain.RoleEntity;
import dendy.rpms.domain.UserEntity;
import dendy.rpms.entity.Role;
import dendy.rpms.entity.User;
import dendy.rpms.page.Pager;
import dendy.rpms.page.PagerUtil;
import dendy.rpms.query.UserQuery;
import dendy.rpms.service.IUserService;
import dendy.rpms.utils.Assert;
import dendy.rpms.utils.MD5Util;
import dendy.rpms.utils.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 用户管理服务实现
 *
 * @author Dendy
 * @since 2014-1-15 11:13:19
 */
@Service("userService")
public class UserServiceImpl implements IUserService {

    @Autowired
    private UserDao dao;

    @Override
    public UserEntity getByName(String userName) {
        Assert.hasLength(userName);
        User user = dao.getByName(userName);
        if (user != null)
            return UserEntity.toDomain(user, true);
        return null;
    }

    @Override
    public UserEntity get(Long id) {
        Assert.notNull(id);
        User user = dao.getById(id);
        if (user != null)
            return UserEntity.toDomain(user, true);
        return null;
    }

    @Override
    @Transactional
    public void editCurrentUserPwd(Long id, String newPwd) {
        Assert.notNull(id);
        Assert.hasLength(newPwd);
        User user = dao.getById(id);
        user.setPassword(newPwd);
        dao.update(user);
    }

    @Override
    @Transactional
    public void update(UserEntity userEntity) {
        Assert.notNull(userEntity);
        User user = dao.getById(userEntity.getId());
        user.setTrueName(userEntity.getTrueName());
        user.setAge(userEntity.getAge());
        user.setSex(userEntity.getSex());
        Integer status = userEntity.getStatus();
        if (status != null)
            user.setStatus(status);

        List<RoleEntity> roleEntityList = userEntity.getRoles();
        if (roleEntityList != null) {
            user.getRoles().clear();
            Set<Role> roles = new HashSet<>();
            for (int i = 0; i < roleEntityList.size(); i++) {
                RoleEntity roleEntity = roleEntityList.get(i);
                Role role = new Role();
                role.setId(roleEntity.getId());
                roles.add(role);
            }
            user.setRoles(roles);
        }

        UserEntity loginUser = UserUtil.getUser();
        User updateUser = new User();
        updateUser.setId(loginUser.getId());

        dao.update(user);
    }

    @Override
    @Transactional
    public void add(UserEntity userEntity) {
        Assert.notNull(userEntity);
        User user = new User();
        user.setName(userEntity.getUsername());
        user.setTrueName(userEntity.getTrueName());
        user.setAge(userEntity.getAge());
        user.setSex(userEntity.getSex());
        user.setPassword(userEntity.getPassword());
        user.setStatus(UserEntity.STATUS_ENABLE);
        user.setCreateTime(new Date());

        List<RoleEntity> roleEntityList = userEntity.getRoles();
        Set<Role> roles = new HashSet<>();
        for (int i = 0; i < roleEntityList.size(); i++) {
            RoleEntity roleEntity = roleEntityList.get(i);
            Role role = new Role();
            role.setId(roleEntity.getId());
            roles.add(role);
        }
        user.setRoles(roles);

        dao.save(user);
    }

    @Override
    @Transactional
    public void delete(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            User user = dao.getById(id);
            // 逻辑删除，非物理删除
            user.setStatus(UserEntity.STATUS_DELETE);
            dao.update(user);
        }
    }

    @Override
    @Transactional
    public void setForbidden(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            User user = dao.getById(id);
            user.setStatus(UserEntity.STATUS_NOT_ENABLE);
            dao.update(user);
        }
    }

    @Override
    @Transactional
    public void setUsing(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            User user = dao.getById(id);
            user.setStatus(UserEntity.STATUS_ENABLE);
            dao.update(user);
        }
    }

    @Override
    @Transactional
    public void resetPwd(String ids) {
        Assert.hasLength(ids);
        String[] idArray = ids.split(",");
        for (int i = 0; i < idArray.length; i++) {
            Long id = Long.parseLong(idArray[i]);
            User user = dao.getById(id);
            user.setPassword(MD5Util.encrypt(SystemConst.DEFAULT_PASSWORD));
            dao.update(user);
        }
    }

    @Override
    public Pager<UserEntity> page(UserQuery userQuery) {
        Assert.notNull(userQuery, "userQuery object must not be null!");
        int beginNum = PagerUtil.getPageStart(userQuery.getPage(), userQuery.getRows());
        long total = dao.findCount(userQuery.getDetachedCriteria());
        if (total > 0) {
            List<User> pageList = dao.findPagerData(userQuery.getDetachedCriteria(), beginNum, userQuery.getRows());
            List<UserEntity> rows = new LinkedList<UserEntity>();
            for (User user : pageList) {
                rows.add(UserEntity.toDomain(user, true));
            }
            return new Pager<UserEntity>(total, rows);
        }
        return new Pager<UserEntity>(total);
    }
}

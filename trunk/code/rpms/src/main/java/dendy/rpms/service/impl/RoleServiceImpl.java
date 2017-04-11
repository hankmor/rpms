package dendy.rpms.service.impl;

import dendy.rpms.dao.RoleDao;
import dendy.rpms.domain.RoleEntity;
import dendy.rpms.entity.Role;
import dendy.rpms.service.IRoleService;
import dendy.rpms.utils.Assert;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service("roleService")
public class RoleServiceImpl implements IRoleService {
    @Autowired
    private RoleDao dao;

    @Override
    public RoleEntity getByRoleCode(final String roleCode, boolean getUsers) {
        Assert.hasLength(roleCode);
        Role role = dao.getByRoleCode(roleCode, getUsers);
        if (role != null)
            return new RoleEntity(role);
        return null;
    }

    @Override
    public List<RoleEntity> getRoles() {
        List<Role> roles = dao.getRoles();
        List<RoleEntity> roleList = new ArrayList<RoleEntity>();
        for (int i = 0; i < roleList.size(); i++) {
            roleList.add(new RoleEntity(roles.get(i)));
        }
        return roleList;
    }
}

package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.entity.Role;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 系统角色dao
 *
 * @author Dendy
 * @since 2013年10月17日
 */
@Repository
public class RoleDao extends BaseDao {
    /**
     * 根据角色code获取角色
     *
     * @param roleCode 角色代码
     * @param cascade  级联查询关联对象
     * @return
     */
    public Role getByRoleCode(final String roleCode, boolean cascade) {
        DetachedCriteria dc = DetachedCriteria.forClass(Role.class);
        dc.add(Restrictions.eq("code", roleCode));
        if (cascade) {
            dc.setFetchMode("users", FetchMode.JOIN);
        }
        @SuppressWarnings("unchecked")
        List<Role> roles = getHibernateTemplate().findByCriteria(dc);
        if (roles != null && roles.size() > 0)
            return roles.get(0);
        return null;
    }

    /**
     * @return Role列表
     * @Description 获取Role列表
     */
    @SuppressWarnings("unchecked")
    public List<Role> getRoles() {
        DetachedCriteria dc = DetachedCriteria.forClass(Role.class);
        List<Role> roles = getHibernateTemplate().findByCriteria(dc);
        return roles;
    }
}

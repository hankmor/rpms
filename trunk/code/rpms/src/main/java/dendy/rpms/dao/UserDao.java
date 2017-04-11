package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.entity.User;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.util.CollectionUtils;

import java.util.List;

@Repository
public class UserDao extends BaseDao {

    /**
     * 根据用户名查询用户
     *
     * @param userName 用户名
     * @return
     */
    public User getByName(String userName) {
        User user = null;
        DetachedCriteria dc = DetachedCriteria.forClass(User.class);
        dc.add(Restrictions.eq("name", userName));
        dc.setFetchMode("roles", FetchMode.JOIN);
        // one to many JOIN方式查询出来可能有多个重复的元素，取第一个即可，判断size需要先将查询结果转为set.
        List<User> users = findCriteriaAll(dc);
        if (!CollectionUtils.isEmpty(users)) {
            user = users.get(0);
        }
        return user;
    }

    /**
     * @param id 用户ID
     * @return 用户信息
     * @Description 根据用户ID查询用户
     */
    public User getById(Long id) {
        User user = null;
        DetachedCriteria dc = DetachedCriteria.forClass(User.class);
        dc.add(Restrictions.eq("id", id));
        dc.setFetchMode("roles", FetchMode.JOIN);
        List<User> users = this.findCriteriaAll(dc);
        if (!CollectionUtils.isEmpty(users)) {
            user = users.get(0);
        }
        return user;
    }
}

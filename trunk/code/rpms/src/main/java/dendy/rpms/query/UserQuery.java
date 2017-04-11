package dendy.rpms.query;

import dendy.rpms.domain.UserEntity;
import dendy.rpms.entity.User;
import dendy.rpms.page.ObjectQuery;
import dendy.rpms.utils.UserUtil;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.util.StringUtils;

/**
 * 用户查询对象，不查询已经被删除的用户
 *
 * @author Dendy
 * @since 14-2-20
 */
public class UserQuery extends ObjectQuery {
    private String username;
    private String trueName;
    private int status = UserEntity.STATUS_DELETE;

    @Override
    public DetachedCriteria getDetachedCriteria() {
        DetachedCriteria dc = DetachedCriteria.forClass(User.class, "user");
        dc.setFetchMode("roles", FetchMode.JOIN);
        // 不查询被删除的用户信息
        dc.add(Restrictions.not(Restrictions.eq("status", status)));
        if (StringUtils.hasLength(username))
            dc.add(Restrictions.ilike("name", username, MatchMode.ANYWHERE));
        if (StringUtils.hasLength(trueName))
            dc.add(Restrictions.ilike("trueName", trueName, MatchMode.ANYWHERE));

        // 不查询自己和超级管理员
        UserEntity loginUser = UserUtil.getUser();
        dc.add(Restrictions.not(Restrictions.eq("id", loginUser.getId())));
        dc.add(Restrictions.not(Restrictions.eq("id", 1L)));

        dc.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return dc;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getTrueName() {
        return trueName;
    }

    public void setTrueName(String trueName) {
        this.trueName = trueName;
    }
}

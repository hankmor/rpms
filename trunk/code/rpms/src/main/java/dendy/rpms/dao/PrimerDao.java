package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.entity.Primer;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

@Repository
public class PrimerDao extends BaseDao {
    public Primer getByCode(String no) {
        if (!StringUtils.hasLength(no)) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Primer.class);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.add(Restrictions.eq("no", no));
        return getUniqueResult(dc);
    }

    public Primer get(Long id) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Primer.class);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.add(Restrictions.eq("id", id));
        return getUniqueResult(dc);
    }
}

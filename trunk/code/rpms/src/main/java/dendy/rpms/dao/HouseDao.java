package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.entity.House;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

@Repository
public class HouseDao extends BaseDao {
    public House getByCode(String no) {
        if (!StringUtils.hasLength(no)) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(House.class);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.add(Restrictions.eq("numer", no));
        return getUniqueResult(dc);
    }

    public House get(Long id) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(House.class);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.add(Restrictions.eq("id", id));
        return getUniqueResult(dc);
    }
}

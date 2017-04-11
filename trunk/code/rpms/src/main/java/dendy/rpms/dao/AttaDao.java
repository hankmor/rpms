package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.entity.Atta;
import org.hibernate.Criteria;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

@Repository
public class AttaDao extends BaseDao {
    public Atta get(Long id) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Atta.class);
        dc.createAlias("userByUploadUser", "uploadUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.add(Restrictions.eq("id", id));
        return getUniqueResult(dc);
    }
}

package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.domain.GenotypeEntity;
import dendy.rpms.entity.Genotype;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;

@Repository
public class GenotypeDao extends BaseDao {
    public Genotype get(Long id) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Genotype.class);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.createAlias("primer", "primer", Criteria.LEFT_JOIN);
        dc.add(Restrictions.eq("id", id));
        return getUniqueResult(dc);
    }

    public Genotype getByNo(String no, String primerNo) {
        if (!StringUtils.hasLength(no) || !StringUtils.hasLength(primerNo)) return null;
        int code = Integer.valueOf(no);
        DetachedCriteria dc = DetachedCriteria.forClass(Genotype.class);
        dc.createAlias("primer", "p");
        dc.add(Restrictions.eq("codeA", code));
        dc.add(Restrictions.eq("p.no", primerNo));
        return getUniqueResult(dc);
    }

    public List<GenotypeEntity> listByCondition(String primerNo, String code) {
        if (!StringUtils.hasLength(primerNo))
            return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Genotype.class);
        dc.createAlias("primer", "primer");
        dc.add(Restrictions.eq("primer.no", primerNo));
        if (StringUtils.hasLength(code)) {
            dc.add(Restrictions.sqlRestriction("this_.code_a like '" + code + "%'"));
        }
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("codeA"), "codeA");
        pl.add(Projections.property("codeB"), "codeB");
        pl.add(Projections.property("primer.id"), "primerId");
        pl.add(Projections.property("primer.no"), "primerNo");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("remark"), "remark");
        dc.setProjection(pl);
        dc.setResultTransformer(Transformers.aliasToBean(GenotypeEntity.class));
        return findCriteriaAll(dc);
    }
}

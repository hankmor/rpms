package dendy.rpms.query;

import dendy.rpms.domain.PrimerEntity;
import dendy.rpms.entity.Primer;
import dendy.rpms.page.ObjectQuery;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.springframework.util.StringUtils;

/**
 * 引物查询对象
 *
 * @author Dendy
 * @since 14-2-20
 */
public class PrimerQuery extends ObjectQuery {
    // 引物编号
    private String no;

    @Override
    public ProjectionList projectionList() {
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("no"), "no");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("remark"), "remark");
        pl.add(Projections.count("genotype.id"), "genotypeCnt");
        pl.add(Projections.groupProperty("id"));
        return pl;
    }

    @Override
    public Class getDomainClass() {
        return PrimerEntity.class;
    }

    @Override
    public DetachedCriteria getDetachedCriteria() {
        DetachedCriteria dc = DetachedCriteria.forClass(Primer.class, "primer");
        // 级联查询创建人和最后修改人
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("genotypes", "genotype", Criteria.LEFT_JOIN);
        if (StringUtils.hasLength(no))
            dc.add(Restrictions.ilike("no", no, MatchMode.ANYWHERE));

        dc.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return dc;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }
}

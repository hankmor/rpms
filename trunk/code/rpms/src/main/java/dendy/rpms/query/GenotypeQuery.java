package dendy.rpms.query;

import dendy.rpms.domain.GenotypeEntity;
import dendy.rpms.entity.Genotype;
import dendy.rpms.page.ObjectQuery;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.springframework.util.StringUtils;

/**
 * 基因型查询对象
 *
 * @author Dendy
 * @since 14-2-20
 */
public class GenotypeQuery extends ObjectQuery {
    // 引物编号
    private String primerNo;
    private String codeA;
    private String codeB;
    private Long animalId;

    @Override
    public ProjectionList projectionList() {
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("createUser.id"), "createUserId");
        pl.add(Projections.property("updateUser.id"), "updateUserId");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("codeA"), "codeA");
        /*实际上基因型对象上没有codeB,用于显示动物的基因型B*/
        if (animalId != null) {
            pl.add(Projections.property("agb.codeA"), "codeB");
        }
        pl.add(Projections.property("primer.id"), "primerId");
        pl.add(Projections.property("primer.no"), "primerNo");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("remark"), "remark");
        return pl;
    }

    @Override
    public Class getDomainClass() {
        return GenotypeEntity.class;
    }

    @Override
    public DetachedCriteria getDetachedCriteria() {
        DetachedCriteria dc = DetachedCriteria.forClass(Genotype.class, "g");
        // 级联查询创建人和最后修改人
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("primer", "primer", Criteria.LEFT_JOIN);

        if (StringUtils.hasLength(primerNo))
            dc.add(Restrictions.ilike("primer.no", primerNo, MatchMode.ANYWHERE));
        if (StringUtils.hasLength(codeA)) {
            // hibernate拼装sql的时候会报类型转换错误.只能用sql写like语句.
            // Restrictions.like("codeA", codeA, MatchMode.ANYWHERE)
            dc.add(Restrictions.sqlRestriction("CODE_A like '%" + codeA + "%'"));
        }
        if (StringUtils.hasLength(codeB)) {
            // dc.add(Restrictions.like("codeB", codeB, MatchMode.ANYWHERE));
            dc.add(Restrictions.sqlRestriction("CODE_B like '%" + codeB + "%'"));
        }
        if (animalId != null) {
            dc.createAlias("animalGenotypesForGenotypeA", "ag", Criteria.LEFT_JOIN);
            dc.createAlias("ag.animal", "animal", Criteria.LEFT_JOIN);
            // 查询基因型B的编码
            dc.createAlias("ag.genotypeByGenotypeB", "agb", Criteria.LEFT_JOIN);
            dc.add(Restrictions.eq("animal.id", animalId));
        }
        dc.addOrder(Order.asc("createTime"));
        return dc;
    }

    public String getPrimerNo() {
        return primerNo;
    }

    public void setPrimerNo(String primerNo) {
        this.primerNo = primerNo;
    }

    public String getCodeA() {
        return codeA;
    }

    public void setCodeA(String codeA) {
        this.codeA = codeA;
    }

    public String getCodeB() {
        return codeB;
    }

    public void setCodeB(String codeB) {
        this.codeB = codeB;
    }

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
    }
}

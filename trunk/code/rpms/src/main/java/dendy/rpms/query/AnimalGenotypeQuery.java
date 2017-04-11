package dendy.rpms.query;

import dendy.rpms.domain.AnimalGenotypeItemEntity;
import dendy.rpms.entity.AnimalGenotype;
import dendy.rpms.page.ObjectQuery;
import dendy.rpms.utils.Assert;
import org.hibernate.criterion.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;

/**
 * <p>Created by Dendy on 2014/11/16.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class AnimalGenotypeQuery extends ObjectQuery {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(AnimalGenotypeQuery.class);

    //~ Instance fields ================================================================================================
    private String codeA;
    private String codeB;
    private String primerNo;
    private Long animalId;
    //~ Methods ========================================================================================================

    @Override
    public ProjectionList projectionList() {
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("animal.id"), "animalId");
        pl.add(Projections.property("p.no"), "primerNo");
        pl.add(Projections.property("a.codeA"), "codeA");
        pl.add(Projections.property("b.codeA"), "codeB");
        pl.add(Projections.property("createTime"), "createTime");
        return pl;
    }

    @Override
    public Class getDomainClass() {
        return AnimalGenotypeItemEntity.class;
    }

    @Override
    public DetachedCriteria getDetachedCriteria() {
        Assert.notNull(animalId);
        DetachedCriteria dc = DetachedCriteria.forClass(AnimalGenotype.class);
        dc.createAlias("primer", "p");
        dc.createAlias("genotypeByGenotypeA", "a", CriteriaSpecification.LEFT_JOIN);
        dc.createAlias("genotypeByGenotypeB", "b", CriteriaSpecification.LEFT_JOIN);
        dc.add(Restrictions.eq("animal.id", animalId));
        if (StringUtils.hasLength(codeA))
            dc.add(Restrictions.sqlRestriction("a2_.CODE_A like '%" + codeA + "%'"));
        if (StringUtils.hasLength(codeB))
            dc.add(Restrictions.sqlRestriction("b3_.CODE_A like '%" + codeB + "%'"));
        if (StringUtils.hasLength(primerNo))
            dc.add(Restrictions.ilike("p.no", primerNo, MatchMode.ANYWHERE));
        dc.addOrder(Order.asc("createTime"));
        return dc;
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

    public String getPrimerNo() {
        return primerNo;
    }

    public void setPrimerNo(String primerNo) {
        this.primerNo = primerNo;
    }

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
    }
}

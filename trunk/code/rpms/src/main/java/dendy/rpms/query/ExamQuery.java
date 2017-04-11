package dendy.rpms.query;

import dendy.rpms.domain.ExaminationEntity;
import dendy.rpms.entity.Examination;
import dendy.rpms.page.ObjectQuery;
import dendy.rpms.utils.Assert;
import org.hibernate.criterion.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Date;

/**
 * <p>Created by Dendy on 2014/9/13.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public class ExamQuery extends ObjectQuery {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(ExamQuery.class);

    //~ Instance fields ================================================================================================
    private Long animalId;
    private Date beginTime;
    private Date endTime;

    //~ Methods ========================================================================================================

    @Override
    public ProjectionList projectionList() {
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("weight"), "weight");
        pl.add(Projections.property("coutourLength"), "coutourLength");
        pl.add(Projections.property("bodyLength"), "bodyLength");
        pl.add(Projections.property("earLength"), "earLength");
        pl.add(Projections.property("tailLength"), "tailLength");
        pl.add(Projections.property("neckGirth"), "neckGirth");
        pl.add(Projections.property("chestGirth"), "chestGirth");
        pl.add(Projections.property("abdominalGirth"), "abdominalGirth");
        pl.add(Projections.property("leftFrontLegLength"), "leftFrontLegLength");
        pl.add(Projections.property("leftBackLegLength"), "leftBackLegLength");
        pl.add(Projections.property("temperature"), "temperature");
        pl.add(Projections.property("examUser"), "examUser");
        pl.add(Projections.property("examTime"), "examTime");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("remark"), "remark");
        return pl;
    }

    @Override
    public Class getDomainClass() {
        return ExaminationEntity.class;
    }

    @Override
    public DetachedCriteria getDetachedCriteria() {
        Assert.notNull(animalId);
        DetachedCriteria dc = DetachedCriteria.forClass(Examination.class);
        dc.createAlias("animal", "animal");
        dc.createAlias("userByUpdateUser", "updateUser", CriteriaSpecification.LEFT_JOIN);
        dc.createAlias("userByCreateUser", "createUser", CriteriaSpecification.LEFT_JOIN);
        dc.add(Restrictions.eq("animal.id", animalId));

        if (beginTime != null)
            dc.add(Restrictions.ge("examTime", beginTime));
        if (endTime != null)
            dc.add(Restrictions.le("examTime", endTime));
        dc.addOrder(Order.desc("examTime"));
        return dc;
    }

    public Long getAnimalId() {
        return animalId;
    }

    public void setAnimalId(Long animalId) {
        this.animalId = animalId;
    }

    public Date getBeginTime() {
        return beginTime;
    }

    public void setBeginTime(Date beginTime) {
        this.beginTime = beginTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }
}

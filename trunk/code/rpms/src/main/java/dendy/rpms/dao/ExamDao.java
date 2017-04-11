package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.domain.AttaEntity;
import dendy.rpms.entity.Atta;
import dendy.rpms.entity.Examination;
import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * <p>Created by Dendy on 2014/9/13.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
@Repository
public class ExamDao extends BaseDao {
    //~ Static fields/initializers =====================================================================================
    private static final Logger LOG = LoggerFactory.getLogger(ExamDao.class);

    public Examination get(Long id) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Examination.class);
        dc.createAlias("animal", "animal");
        dc.add(Restrictions.eq("id", id));
        return getUniqueResult(dc);
    }

    public List<AttaEntity> listAttas(Long id, byte examAttaTypeFacade) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Atta.class);
        dc.createAlias("examinationAttas", "ea");
        dc.createAlias("ea.examination", "eae");
        dc.add(Restrictions.eq("ea.examination.id", id));
        dc.add(Restrictions.eq("ea.type", examAttaTypeFacade));

        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("name"), "name");
        pl.add(Projections.property("size"), "size");
        pl.add(Projections.property("fileName"), "fileName");
        pl.add(Projections.property("path"), "path");
        pl.add(Projections.property("type"), "type");
        pl.add(Projections.property("description"), "description");
        pl.add(Projections.property("uploadTime"), "uploadTime");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("remark"), "remark");
        dc.setProjection(pl);
        dc.setResultTransformer(Transformers.aliasToBean(AttaEntity.class));

        return getHibernateTemplate().findByCriteria(dc);
    }

    public Examination getWithAttas(Long id) {
        if (id == null) return null;
        DetachedCriteria dc = DetachedCriteria.forClass(Examination.class);
        dc.setFetchMode("examinationAttas", FetchMode.JOIN);
        dc.add(Restrictions.eq("id", id));
        return getUniqueResult(dc);
    }
}

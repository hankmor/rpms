package dendy.rpms.query;

import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.entity.AnimalType;
import dendy.rpms.page.ObjectQuery;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.springframework.util.StringUtils;

/**
 * 动物类型查询对象
 *
 * @author Dendy
 * @since 14-2-20
 */
public class AnimalTypeQuery extends ObjectQuery {
    private String name;

    @Override
    public ProjectionList projectionList() {
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("name"), "name");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("remark"), "remark");
        return pl;
    }

    @Override
    public Class getDomainClass() {
        return AnimalTypeEntity.class;
    }

    @Override
    public DetachedCriteria getDetachedCriteria() {
        DetachedCriteria dc = DetachedCriteria.forClass(AnimalType.class);
        // 级联查询创建人和最后修改人
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        if (StringUtils.hasLength(name))
            dc.add(Restrictions.ilike("name", name, MatchMode.ANYWHERE));
        dc.setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
        return dc;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

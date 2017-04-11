package dendy.rpms.query;

import dendy.rpms.domain.HouseEntity;
import dendy.rpms.entity.House;
import dendy.rpms.page.ObjectQuery;
import org.hibernate.Criteria;
import org.hibernate.criterion.*;
import org.springframework.util.StringUtils;

/**
 * 圈舍查询对象
 *
 * @author Dendy
 * @since 14-2-20
 */
public class HouseQuery extends ObjectQuery {
    // 圈舍编号
    private String numer;
    // 圈舍名称
    private String name;
    // 位置
    private String location;
    // 不查询的圈舍编号，都好分割
    private String excludesNumber;

    @Override
    public ProjectionList projectionList() {
        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("numer"), "numer");
        pl.add(Projections.property("name"), "name");
        pl.add(Projections.property("location"), "location");
        pl.add(Projections.property("zoo"), "zoo");
        pl.add(Projections.property("description"), "description");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("remark"), "remark");
        pl.add(Projections.count("animal.id"), "cnt");
        pl.add(Projections.groupProperty("id"));
        return pl;
    }

    @Override
    public Class getDomainClass() {
        return HouseEntity.class;
    }

    @Override
    public DetachedCriteria getDetachedCriteria() {
        DetachedCriteria dc = DetachedCriteria.forClass(House.class, "house");
        // 级联查询创建人和最后修改人
        dc.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);
        dc.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        dc.createAlias("animals", "animal", Criteria.LEFT_JOIN);
        if (StringUtils.hasLength(numer))
            dc.add(Restrictions.ilike("numer", numer, MatchMode.ANYWHERE));
        if (StringUtils.hasLength(name))
            dc.add(Restrictions.ilike("name", name, MatchMode.ANYWHERE));
        if (StringUtils.hasLength(location))
            dc.add(Restrictions.ilike("location", location, MatchMode.ANYWHERE));
        if (StringUtils.hasLength(excludesNumber)) {
            String[] numbers = excludesNumber.split(",");
            dc.add(Restrictions.not(Restrictions.in("numer", numbers)));
        }
        return dc;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getNumer() {
        return numer;
    }

    public void setNumer(String numer) {
        this.numer = numer;
    }

    public String getExcludesNumber() {
        return excludesNumber;
    }

    public void setExcludesNumber(String excludesNumber) {
        this.excludesNumber = excludesNumber;
    }
}

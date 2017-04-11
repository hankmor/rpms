package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.domain.AnimalTypeEntity;
import dendy.rpms.entity.AnimalType;
import org.hibernate.Criteria;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class AnimalTypeDao extends BaseDao {
    public List<AnimalTypeEntity> getAll() {
        Criteria criteria = getCriteria(AnimalType.class);
        criteria.createAlias("userByUpdateUser", "updateUser", Criteria.LEFT_JOIN);
        criteria.createAlias("userByCreateUser", "createUser", Criteria.LEFT_JOIN);

        ProjectionList pl = Projections.projectionList();
        pl.add(Projections.property("id"), "id");
        pl.add(Projections.property("name"), "name");
        pl.add(Projections.property("updateUser.name"), "updateUserName");
        pl.add(Projections.property("createUser.name"), "createUserName");
        pl.add(Projections.property("createTime"), "createTime");
        pl.add(Projections.property("updateTime"), "updateTime");
        pl.add(Projections.property("remark"), "remark");

        criteria.setProjection(pl);
        criteria.setResultTransformer(Transformers.aliasToBean(AnimalTypeEntity.class));
        return criteria.list();
    }

    public AnimalType get(Long id) {
        if (id == null) return null;
        return super.get(AnimalType.class, id);
    }

    public AnimalType add(AnimalType animalType) {
        if (animalType == null) return null;
        super.save(animalType);
        return animalType;
    }

    public AnimalType update(AnimalType animalType) {
        if (animalType == null) return null;
        super.update(animalType);
        return animalType;
    }

    public void delete(Long id) {
        if (id == null) return;
        super.delete(AnimalType.class, id);
    }
}

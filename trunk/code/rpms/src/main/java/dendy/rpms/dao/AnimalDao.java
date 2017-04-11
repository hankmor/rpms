package dendy.rpms.dao;

import dendy.rpms.dao.base.BaseDao;
import dendy.rpms.domain.AttaEntity;
import dendy.rpms.entity.Animal;
import dendy.rpms.entity.AnimalGenotype;
import dendy.rpms.entity.AnimalGenotypeId;
import dendy.rpms.entity.Atta;
import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.criterion.*;
import org.hibernate.transform.Transformers;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import java.util.List;

@Repository
public class AnimalDao extends BaseDao {
	public Animal getWithType(Long id) {
		if (id == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.createAlias("animalType", "type", CriteriaSpecification.LEFT_JOIN);
		dc.add(Restrictions.eq("id", id));
		return getUniqueResult(dc);
	}

	public Animal getWithParentsAndAtta(Long id) {
		if (id == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.createAlias("animalByFather", "father", Criteria.LEFT_JOIN);
		dc.createAlias("animalByMother", "mother", Criteria.LEFT_JOIN);
		dc.createAlias("atta", "atta", Criteria.LEFT_JOIN);
		dc.add(Restrictions.eq("id", id));
		return getUniqueResult(dc);
	}

	public Animal getWithChildrenAndAtta(Long id) {
		if (id == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.setFetchMode("animalsForMother", FetchMode.JOIN);
		dc.setFetchMode("animalsForFather", FetchMode.JOIN);
		dc.createAlias("atta", "atta", Criteria.LEFT_JOIN);
		dc.add(Restrictions.eq("id", id));
		return getUniqueResult(dc);
	}

	public Animal get(Long id) {
		if (id == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.createAlias("animalByFather", "father", Criteria.LEFT_JOIN);
		dc.createAlias("animalByMother", "mother", Criteria.LEFT_JOIN);
		dc.setFetchMode("animalsForMother", FetchMode.JOIN);
		dc.setFetchMode("animalsForFather", FetchMode.JOIN);
		dc.createAlias("house", "house", Criteria.LEFT_JOIN);
		dc.createAlias("atta", "atta", Criteria.LEFT_JOIN);
		dc.add(Restrictions.eq("id", id));
		return getUniqueResult(dc);
	}

	public Animal getByMicrochipCode(String no) {
		if (!StringUtils.hasLength(no))
			return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.createAlias("animalByFather", "father", Criteria.LEFT_JOIN);
		dc.createAlias("animalByMother", "mother", Criteria.LEFT_JOIN);
		dc.createAlias("house", "house", Criteria.LEFT_JOIN);
		dc.createAlias("atta", "atta", Criteria.LEFT_JOIN);
		dc.add(Restrictions.eq("microchipCode", no));
		return getUniqueResult(dc);
	}

	public Animal getByNo(String no) {
		if (!StringUtils.hasLength(no))
			return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.createAlias("animalByFather", "father", Criteria.LEFT_JOIN);
		dc.createAlias("animalByMother", "mother", Criteria.LEFT_JOIN);
		dc.createAlias("house", "house", Criteria.LEFT_JOIN);
		dc.createAlias("atta", "atta", Criteria.LEFT_JOIN);
		dc.add(Restrictions.eq("tatooCode", no));
		return getUniqueResult(dc);
	}

	public Animal getWithGenotypes(Long id) {
		if (id == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.createAlias("animalGenotypes", "ag", CriteriaSpecification.LEFT_JOIN);
		dc.createAlias("ag.primer", "agp", CriteriaSpecification.LEFT_JOIN);
		dc.createAlias("ag.genotypeByGenotypeB", "aga", CriteriaSpecification.LEFT_JOIN);
		dc.createAlias("ag.genotypeByGenotypeA", "agb", CriteriaSpecification.LEFT_JOIN);
		dc.add(Restrictions.eq("id", id));
		return getUniqueResult(dc);
	}

	public Animal getByNoWithGenotypes(String no) {
		if (!StringUtils.hasLength(no)) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.createAlias("animalGenotypes", "ag", CriteriaSpecification.LEFT_JOIN);
		dc.createAlias("ag.primer", "agp", CriteriaSpecification.LEFT_JOIN);
		dc.createAlias("ag.genotypeByGenotypeB", "aga", CriteriaSpecification.LEFT_JOIN);
		dc.createAlias("ag.genotypeByGenotypeA", "agb", CriteriaSpecification.LEFT_JOIN);
		dc.add(Restrictions.eq("tatooCode", no));
		return getUniqueResult(dc);
	}

	public Animal getWithAttas(Long id) {
		if (id == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.setFetchMode("attas", FetchMode.JOIN);
		dc.add(Restrictions.eq("id", id));
		return getUniqueResult(dc);
	}

	public List<AttaEntity> listAttas(Long animalId) {
		if (animalId == null)
			return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Atta.class);
		dc.createAlias("animals", "animal", CriteriaSpecification.LEFT_JOIN);
		dc.add(Restrictions.eq("animal.id", animalId));

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

	public Animal getWithExams(Long id) {
		if (id == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(Animal.class);
		dc.setFetchMode("examinations", FetchMode.JOIN);
		dc.add(Restrictions.eq("id", id));
		return getUniqueResult(dc);
	}

	public void addAnimalGenotype(AnimalGenotype animalGenotype) {
		if (animalGenotype == null) return;
		save(animalGenotype);
	}

	public void deleteAnimalGenotype(AnimalGenotypeId animalGenotypeId) {
		if (animalGenotypeId == null) return;
		delete(AnimalGenotype.class, animalGenotypeId);
	}

	public AnimalGenotype getAnimalGenotype(AnimalGenotypeId animalGenotypeId) {
		if (animalGenotypeId == null) return null;
		DetachedCriteria dc = DetachedCriteria.forClass(AnimalGenotype.class);
		dc.add(Restrictions.eq("id", animalGenotypeId));
		return getUniqueResult(dc);
	}

	public AnimalGenotype getGenotype(Long animalId, Long primerId) {
		if (animalId == null || primerId == null)
			return null;
		DetachedCriteria dc = DetachedCriteria.forClass(AnimalGenotype.class);
		dc.add(Restrictions.eq("id.animal", animalId));
		dc.add(Restrictions.eq("id.primer", primerId));
		return getUniqueResult(dc);
	}
}

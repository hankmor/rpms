package dendy.rpms.service;

import dendy.rpms.domain.AnimalGenotypeItemEntity;
import dendy.rpms.query.AnimalGenotypeQuery;

/**
 * <p>Created by Dendy on 2014/11/16.
 *
 * @author Dendy
 * @version 0.1
 * @since 0.1
 */
public interface IAnimalGenotypeSerice {
    dendy.rpms.page.Pager<AnimalGenotypeItemEntity> page(AnimalGenotypeQuery animalGenotypeQuery);
}
